"""Generate BLACK VECTOR's original opening-state Corley character.

All geometry, rig data, materials, and animation keys are authored here. The
generator uses only Blender's built-in mesh and glTF tools; it downloads no
assets and contacts no remote service.
"""

import math
import os

import bpy
from mathutils import Vector


OUT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../game/assets/characters/corley_opening.glb"))


def clear_scene():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for datablocks in (bpy.data.meshes, bpy.data.curves, bpy.data.materials, bpy.data.armatures, bpy.data.actions):
        for datablock in list(datablocks):
            if datablock.users == 0:
                datablocks.remove(datablock)


def make_material(name, color, roughness, metallic=0.0):
    material = bpy.data.materials.new(name)
    material.diffuse_color = (*color, 1.0)
    material.use_nodes = True
    principled = material.node_tree.nodes.get("Principled BSDF")
    principled.inputs["Base Color"].default_value = (*color, 1.0)
    principled.inputs["Roughness"].default_value = roughness
    principled.inputs["Metallic"].default_value = metallic
    return material


def create_rig():
    data = bpy.data.armatures.new("CorleyHumanoidRig")
    armature = bpy.data.objects.new("CorleyRig", data)
    bpy.context.collection.objects.link(armature)
    bpy.context.view_layer.objects.active = armature
    armature.select_set(True)
    bpy.ops.object.mode_set(mode="EDIT")
    definitions = {
        "root": ((0, 0, 0.0), (0, 0, 0.12), None),
        "hips": ((0, 0, 0.86), (0, 0, 1.04), "root"),
        "spine": ((0, 0, 1.02), (0, 0, 1.30), "hips"),
        "chest": ((0, 0, 1.28), (0, 0, 1.49), "spine"),
        "neck": ((0, 0, 1.47), (0, 0, 1.62), "chest"),
        "head": ((0, 0, 1.59), (0, 0, 1.88), "neck"),
    }
    for side, sign in (("L", 1), ("R", -1)):
        definitions.update({
            f"upper_arm.{side}": ((0.19 * sign, 0, 1.43), (0.34 * sign, 0, 1.20), "chest"),
            f"forearm.{side}": ((0.34 * sign, 0, 1.20), (0.43 * sign, -0.015, 0.98), f"upper_arm.{side}"),
            f"hand.{side}": ((0.43 * sign, -0.015, 0.98), (0.44 * sign, -0.06, 0.84), f"forearm.{side}"),
            f"thigh.{side}": ((0.12 * sign, 0, 0.94), (0.13 * sign, 0, 0.52), "hips"),
            f"shin.{side}": ((0.13 * sign, 0, 0.52), (0.13 * sign, 0, 0.12), f"thigh.{side}"),
            f"foot.{side}": ((0.13 * sign, 0, 0.12), (0.13 * sign, -0.27, 0.07), f"shin.{side}"),
        })
    bones = {}
    for name, (head, tail, parent) in definitions.items():
        bone = data.edit_bones.new(name)
        bone.head = head
        bone.tail = tail
        if parent:
            bone.parent = data.edit_bones[parent]
        bones[name] = bone
    bpy.ops.object.mode_set(mode="OBJECT")
    armature.show_in_front = True
    armature.select_set(False)
    return armature


def weighted_object(name, vertices, faces, material, weight_fn, smooth=True):
    mesh = bpy.data.meshes.new(name + "Mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    mesh.update()
    obj = bpy.data.objects.new(name, mesh)
    bpy.context.collection.objects.link(obj)
    obj.parent = RIG
    if smooth:
        for polygon in mesh.polygons:
            polygon.use_smooth = True
    groups = {}
    for vertex in mesh.vertices:
        weights = weight_fn(vertex.co)
        for group_name, weight in weights.items():
            if weight <= 0.001:
                continue
            if group_name not in groups:
                groups[group_name] = obj.vertex_groups.new(name=group_name)
            groups[group_name].add([vertex.index], float(weight), "REPLACE")
    modifier = obj.modifiers.new("Corley skeletal skin", "ARMATURE")
    modifier.object = RIG
    modifier.use_deform_preserve_volume = True
    return obj


def uniform(bone):
    return lambda _point: {bone: 1.0}


def torso_weights(point):
    z = point.z
    if z < 1.00:
        return {"hips": 1.0}
    if z < 1.10:
        t = (z - 1.00) / 0.10
        return {"hips": 1.0 - t, "spine": t}
    if z < 1.25:
        return {"spine": 1.0}
    if z < 1.36:
        t = (z - 1.25) / 0.11
        return {"spine": 1.0 - t, "chest": t}
    if z < 1.50:
        return {"chest": 1.0}
    if z < 1.57:
        t = (z - 1.50) / 0.07
        return {"chest": 1.0 - t, "neck": t}
    return {"neck": 1.0}


def torso_shell(name, rings, material, weights=torso_weights, sides=28):
    vertices, faces = [], []
    for z, radius_x, radius_y, center_y in rings:
        for side in range(sides):
            angle = 2 * math.pi * side / sides
            vertices.append((math.cos(angle) * radius_x, center_y + math.sin(angle) * radius_y, z))
    for ring in range(len(rings) - 1):
        for side in range(sides):
            a = ring * sides + side
            b = ring * sides + (side + 1) % sides
            c = (ring + 1) * sides + side
            d = (ring + 1) * sides + (side + 1) % sides
            faces.extend(((a, b, c), (b, d, c)))
    faces.append(tuple(range(sides - 1, -1, -1)))
    faces.append(tuple((len(rings) - 1) * sides + side for side in range(sides)))
    return weighted_object(name, vertices, faces, material, weights)


def ellipsoid(name, center, scale, material, bone, segments=20, rings=14, rotation=None):
    vertices, faces = [], []
    cx, cy, cz = center
    for ring in range(rings + 1):
        lat = -math.pi / 2 + math.pi * ring / rings
        for side in range(segments):
            lon = 2 * math.pi * side / segments
            x = math.cos(lat) * math.cos(lon) * scale[0]
            y = math.cos(lat) * math.sin(lon) * scale[1]
            z = math.sin(lat) * scale[2]
            point = Vector((x, y, z))
            if rotation is not None:
                point = rotation @ point
            vertices.append((cx + point.x, cy + point.y, cz + point.z))
    for ring in range(rings):
        for side in range(segments):
            a = ring * segments + side
            b = ring * segments + (side + 1) % segments
            c = (ring + 1) * segments + side
            d = (ring + 1) * segments + (side + 1) % segments
            faces.extend(((a, c, b), (b, c, d)))
    return weighted_object(name, vertices, faces, material, uniform(bone))


def tube(name, start, end, radii, material, bone_fn, sides=14, elliptic=1.0):
    a, b = Vector(start), Vector(end)
    axis = (b - a).normalized()
    tangent = axis.cross(Vector((0, 1, 0)))
    if tangent.length < 0.05:
        tangent = axis.cross(Vector((1, 0, 0)))
    tangent.normalize()
    bitangent = axis.cross(tangent).normalized()
    vertices, faces = [], []
    for index, (t, radius) in enumerate(radii):
        center = a.lerp(b, t)
        for side in range(sides):
            angle = 2 * math.pi * side / sides
            point = center + tangent * math.cos(angle) * radius + bitangent * math.sin(angle) * radius * elliptic
            vertices.append(tuple(point))
    for ring in range(len(radii) - 1):
        for side in range(sides):
            a0 = ring * sides + side
            a1 = ring * sides + (side + 1) % sides
            b0 = (ring + 1) * sides + side
            b1 = (ring + 1) * sides + (side + 1) % sides
            faces.extend(((a0, b0, a1), (a1, b0, b1)))
    return weighted_object(name, vertices, faces, material, bone_fn)


def arm_weights(side, t):
    upper, forearm, hand = f"upper_arm.{side}", f"forearm.{side}", f"hand.{side}"
    if t < 0.48:
        return {upper: 1.0}
    if t < 0.64:
        blend = (t - 0.48) / 0.16
        return {upper: 1.0 - blend, forearm: blend}
    if t < 0.88:
        return {forearm: 1.0}
    blend = min(1.0, (t - 0.88) / 0.12)
    return {forearm: 1.0 - blend, hand: blend}


def leg_weights(side, t):
    thigh, shin, foot = f"thigh.{side}", f"shin.{side}", f"foot.{side}"
    if t < 0.43:
        return {thigh: 1.0}
    if t < 0.57:
        blend = (t - 0.43) / 0.14
        return {thigh: 1.0 - blend, shin: blend}
    if t < 0.9:
        return {shin: 1.0}
    blend = min(1.0, (t - 0.9) / 0.1)
    return {shin: 1.0 - blend, foot: blend}


def arm_vertex_weights(point, side, sign):
    start = Vector((0.20 * sign, 0, 1.43))
    end = Vector((0.43 * sign, -0.015, 0.98))
    axis = end - start
    t = (Vector(point) - start).dot(axis) / axis.length_squared
    return arm_weights(side, min(1.0, max(0.0, t)))


def make_limbs():
    torso_shell("CorleyBody", [
        (0.85, 0.18, 0.125, 0), (0.93, 0.205, 0.14, 0),
        (1.03, 0.175, 0.12, 0), (1.14, 0.16, 0.118, 0),
        (1.28, 0.205, 0.135, 0), (1.39, 0.225, 0.145, 0),
        (1.48, 0.185, 0.12, 0), (1.55, 0.105, 0.095, 0),
        (1.62, 0.078, 0.073, 0),
    ], SKIN)
    torso_shell("OpeningTankTop", [
        (1.07, 0.185, 0.128, 0), (1.13, 0.176, 0.127, 0),
        (1.25, 0.205, 0.145, 0), (1.37, 0.238, 0.158, 0),
        (1.46, 0.205, 0.137, 0), (1.505, 0.166, 0.112, 0),
    ], TANK)
    # Narrow shoulder straps and worn binding make the minimal upper garment read as cloth.
    for side, sign in (("L", -1), ("R", 1)):
        x0 = 0.105 * sign
        x1 = 0.15 * sign
        tube(f"TankStrap_{side}", (x0, 0, 1.43), (x1, 0, 1.505), [(0, 0.032), (0.5, 0.034), (1, 0.031)], TANK_EDGE, uniform("chest"), 8, 0.65)
        tube(f"ArmSkin_{side}", (0.20 * sign, 0, 1.43), (0.43 * sign, -0.015, 0.98), [
            (0, 0.096), (0.16, 0.106), (0.38, 0.091), (0.57, 0.076), (0.80, 0.073), (1, 0.065)
        ], SKIN, lambda p, s=side, sign_value=sign: arm_vertex_weights(p, s, sign_value))
        ellipsoid(f"Hand_{side}", (0.44 * sign, -0.04, 0.91), (0.058, 0.041, 0.087), SKIN, f"hand.{side}", 16, 10)
        # Fine separated fingers remain rigged to the hand and read at conversational range.
        for finger in range(4):
            fx = (0.405 + finger * 0.023) * sign
            fy = -0.075 - (0.006 if finger in (1, 2) else 0.0)
            tube(f"Finger_{side}_{finger}", (fx, fy, 0.885), (fx, fy - 0.018, 0.835 + (0.008 if finger in (1, 2) else 0)),
                 [(0, 0.011), (0.6, 0.009), (1, 0.006)], SKIN, uniform(f"hand.{side}"), 7, 0.8)

        hip_x = 0.13 * sign
        tube(f"PrisonTrousers_{side}", (hip_x, 0, 0.94), (hip_x, 0, 0.10), [
            (0, 0.114), (0.12, 0.113), (0.25, 0.105), (0.43, 0.091),
            (0.55, 0.091), (0.72, 0.079), (0.9, 0.073), (1, 0.078)
        ], TROUSERS, lambda p, s=side: leg_weights(s, min(1.0, max(0.0, (0.94 - Vector(p).z) / 0.84))), 16, 0.82)
        # A frayed rolled cuff and a torn knee patch are separate cloth layers.
        tube(f"TrouserCuff_{side}", (hip_x, 0, 0.115), (hip_x, 0, 0.145), [(0, 0.078), (0.5, 0.081), (1, 0.078)], TROUSER_SEAM, uniform(f"shin.{side}"), 16, 0.82)
        ellipsoid(f"KneeRepair_{side}", (hip_x, -0.088, 0.52), (0.036, 0.006, 0.041), PATCH, f"thigh.{side}", 20, 12)
        tube(f"ShinSeam_{side}", (hip_x + sign * 0.071, -0.005, 0.25), (hip_x + sign * 0.071, -0.005, 0.46),
             [(0, 0.008), (0.5, 0.008), (1, 0.008)], TROUSER_SEAM, uniform(f"shin.{side}"), 6, 0.5)

        # Thin, soft slip-ons are deliberately poor opening footwear, not tactical boots.
        ellipsoid(f"WornSlipOn_{side}", (hip_x, -0.082, 0.078), (0.078, 0.18, 0.052), SHOE, f"foot.{side}", 20, 12)
        ellipsoid(f"ThinSole_{side}", (hip_x, -0.079, 0.034), (0.081, 0.183, 0.018), SOLE, f"foot.{side}", 20, 10)
        for lace in range(3):
            ellipsoid(f"SlipOnStitch_{side}_{lace}", (hip_x, -0.103 + lace * 0.028, 0.119), (0.042, 0.007, 0.008), PATCH, f"foot.{side}", 10, 6)

        # The upper arm is a skin mesh; no polished armor or tactical equipment is fitted.
        ellipsoid(f"ElbowWear_{side}", (0.342 * sign, -0.01, 1.19), (0.081, 0.074, 0.088), SKIN, f"forearm.{side}", 16, 10)


def make_head_and_hair():
    ellipsoid("CorleyHead", (0, -0.005, 1.74), (0.124, 0.112, 0.166), SKIN, "head", 28, 20)
    ellipsoid("CorleyNeck", (0, 0.012, 1.575), (0.071, 0.071, 0.105), SKIN, "neck", 18, 12)
    # Jaw, cheek planes, nose bridge and ears are softly rounded, avoiding a toy-like sphere head.
    ellipsoid("JawPlane", (0, -0.043, 1.674), (0.093, 0.079, 0.072), SKIN, "head", 20, 12)
    ellipsoid("NoseBridge", (0, -0.112, 1.735), (0.024, 0.031, 0.056), SKIN, "head", 14, 10)
    ellipsoid("NoseTip", (0, -0.135, 1.711), (0.028, 0.024, 0.018), SKIN, "head", 14, 8)
    for sign, side in ((-1, "L"), (1, "R")):
        ellipsoid(f"Ear_{side}", (0.122 * sign, 0.0, 1.742), (0.025, 0.032, 0.044), SKIN, "head", 14, 10)
        ellipsoid(f"EyeSocket_{side}", (0.047 * sign, -0.099, 1.768), (0.027, 0.010, 0.017), EYE_WHITE, "head", 18, 10)
        ellipsoid(f"Iris_{side}", (0.047 * sign, -0.109, 1.768), (0.008, 0.005, 0.011), EYE, "head", 14, 10)
        tube(f"Brow_{side}", (0.019 * sign, -0.103, 1.796), (0.078 * sign, -0.091, 1.802),
             [(0, 0.009), (0.5, 0.011), (1, 0.007)], HAIR, uniform("head"), 7)
        ellipsoid(f"GaugedEarring_{side}", (0.122 * sign, -0.018, 1.704), (0.012, 0.009, 0.020), METAL, "head", 12, 8)

    # Healed scar above Corley's right eye. Its placement is fixed in character space.
    tube("ScarAboveRightEye", (0.031, -0.113, 1.817), (0.075, -0.097, 1.826),
         [(0, 0.004), (0.45, 0.006), (1, 0.003)], SCAR, uniform("head"), 7)

    # Scalp cap with swept-back strands reaching the upper back.
    ellipsoid("AuburnScalp", (0, 0.012, 1.808), (0.132, 0.122, 0.115), HAIR, "head", 24, 16)
    for side in range(13):
        angle = 2 * math.pi * side / 13
        sx = math.cos(angle) * 0.104
        sy = 0.012 + math.sin(angle) * 0.092
        start = (sx, sy, 1.817 + 0.022 * math.sin(angle * 2))
        end = (sx * 0.72, 0.125 + 0.022 * math.sin(angle * 3), 1.485 + 0.055 * (1 + math.sin(angle)))
        radius = 0.016 + (side % 3) * 0.0025
        tube(f"LongAuburnLock_{side:02d}", start, end,
             [(0, radius), (0.22, radius * 0.98), (0.53, radius * 0.82), (0.82, radius * 0.58), (1, 0.003)],
             HAIR if side % 3 else HAIR_LIGHT, uniform("head"), 9, 0.72)
    # A center-parted hairline is made from tapered locks, leaving the face readable.
    for side, sign in (("L", -1), ("R", 1)):
        tube(f"TempleLock_{side}", (0.102 * sign, -0.039, 1.86), (0.092 * sign, -0.028, 1.64),
             [(0, 0.027), (0.38, 0.022), (0.75, 0.013), (1, 0.003)], HAIR, uniform("head"), 10, 0.72)


def add_animation(name, duration, poses, loop=False):
    action = bpy.data.actions.new(name)
    RIG.animation_data_create()
    RIG.animation_data.action = action
    for frame, values in poses:
        bpy.context.scene.frame_set(frame)
        for bone_name, rotation in values.items():
            bone = RIG.pose.bones[bone_name]
            bone.rotation_mode = "XYZ"
            bone.rotation_euler = rotation
            bone.keyframe_insert(data_path="rotation_euler", frame=frame, group=bone_name)
    action.frame_range = (1, duration)
    for curve in action.fcurves:
        for key in curve.keyframe_points:
            key.interpolation = "BEZIER"
        if loop:
            curve.modifiers.new("CYCLES")
    RIG.animation_data.action = None
    return action


def make_animations():
    xrot = lambda value: (value, 0.0, 0.0)
    base = {bone: (0.0, 0.0, 0.0) for bone in RIG.pose.bones.keys()}
    idle = dict(base)
    idle["chest"] = xrot(-0.018)
    add_animation("idle", 48, [(1, base), (24, idle), (48, base)], True)
    walk_a, walk_b = dict(base), dict(base)
    walk_a.update({"thigh.L": xrot(0.34), "thigh.R": xrot(-0.34), "upper_arm.L": xrot(-0.22), "upper_arm.R": xrot(0.22), "chest": xrot(-0.035)})
    walk_b.update({"thigh.L": xrot(-0.34), "thigh.R": xrot(0.34), "upper_arm.L": xrot(0.22), "upper_arm.R": xrot(-0.22), "chest": xrot(-0.025)})
    add_animation("walk", 32, [(1, base), (9, walk_a), (17, base), (25, walk_b), (32, base)], True)
    run_a, run_b = dict(base), dict(base)
    run_a.update({"thigh.L": xrot(0.62), "thigh.R": xrot(-0.62), "shin.L": xrot(-0.18), "shin.R": xrot(0.18), "upper_arm.L": xrot(-0.42), "upper_arm.R": xrot(0.42), "chest": xrot(-0.10)})
    run_b.update({"thigh.L": xrot(-0.62), "thigh.R": xrot(0.62), "shin.L": xrot(0.18), "shin.R": xrot(-0.18), "upper_arm.L": xrot(0.42), "upper_arm.R": xrot(-0.42), "chest": xrot(-0.08)})
    add_animation("run", 24, [(1, base), (7, run_a), (13, base), (19, run_b), (24, base)], True)
    crouch = dict(base)
    crouch.update({"hips": xrot(-0.42), "spine": xrot(0.30), "chest": xrot(-0.17), "thigh.L": xrot(0.56), "thigh.R": xrot(0.56), "shin.L": xrot(-0.74), "shin.R": xrot(-0.74), "head": xrot(-0.04)})
    add_animation("crouch", 24, [(1, base), (12, crouch), (24, crouch)], True)
    crouch_a, crouch_b = dict(crouch), dict(crouch)
    crouch_a.update({"thigh.L": xrot(0.70), "thigh.R": xrot(0.45), "upper_arm.L": xrot(-0.14), "upper_arm.R": xrot(0.14)})
    crouch_b.update({"thigh.L": xrot(0.45), "thigh.R": xrot(0.70), "upper_arm.L": xrot(0.14), "upper_arm.R": xrot(-0.14)})
    add_animation("crouch_walk", 30, [(1, crouch), (8, crouch_a), (16, crouch), (23, crouch_b), (30, crouch)], True)
    turn = dict(base)
    turn.update({"spine": xrot(-0.12), "chest": (0.0, 0.0, 0.18), "head": (0.0, 0.0, 0.28)})
    add_animation("turn", 18, [(1, base), (9, turn), (18, base)])
    interaction = dict(base)
    interaction.update({"upper_arm.R": xrot(-0.62), "forearm.R": xrot(-0.58), "chest": xrot(-0.06)})
    add_animation("interaction", 22, [(1, base), (8, interaction), (15, interaction), (22, base)])
    hurt = dict(base)
    hurt.update({"chest": xrot(-0.24), "head": xrot(0.18), "upper_arm.L": xrot(0.34), "upper_arm.R": xrot(-0.26)})
    add_animation("hurt", 20, [(1, base), (5, hurt), (11, hurt), (20, base)])
    recoil = dict(base)
    recoil.update({"chest": xrot(-0.29), "upper_arm.L": xrot(-0.58), "upper_arm.R": xrot(-0.72), "forearm.R": xrot(-0.33)})
    add_animation("recoil", 18, [(1, base), (4, recoil), (9, recoil), (18, base)])
    stance = dict(base)
    stance.update({"upper_arm.L": xrot(-0.48), "upper_arm.R": xrot(-0.40), "forearm.L": xrot(-0.23), "forearm.R": xrot(-0.30), "chest": xrot(-0.07)})
    add_animation("combat_stance", 24, [(1, base), (10, stance), (24, stance)], True)
    prone = dict(base)
    prone.update({"hips": xrot(1.35), "spine": xrot(-0.20), "chest": xrot(-0.10), "head": xrot(0.22), "thigh.L": xrot(-1.30), "thigh.R": xrot(-1.30)})
    add_animation("prone", 24, [(1, base), (12, prone), (24, prone)], True)
    add_animation("prone_crawl", 24, [(1, prone), (7, dict(prone, **{"upper_arm.L": xrot(-0.32), "thigh.R": xrot(-1.02)})),
                                      (13, prone), (19, dict(prone, **{"upper_arm.R": xrot(-0.32), "thigh.L": xrot(-1.02)})), (24, prone)], True)
    # Export names expected by the Godot state bridge.
    alias_action("sprint", "run")
    alias_action("jog", "run")
    alias_action("air", "run")


def alias_action(alias, source):
    duplicate = bpy.data.actions[source].copy()
    duplicate.name = alias


def export_glb():
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    bpy.ops.object.select_all(action="DESELECT")
    RIG.select_set(True)
    for obj in bpy.context.scene.objects:
        if obj.type == "MESH":
            obj.select_set(True)
    bpy.context.view_layer.objects.active = RIG
    bpy.ops.export_scene.gltf(
        filepath=OUT,
        export_format="GLB",
        export_animations=True,
        export_animation_mode="ACTIONS",
        export_skins=True,
        export_yup=True,
        export_apply=True,
        export_force_sampling=True,
    )


clear_scene()
# Materials are created before clearing to keep this script easy to rerun.
# clear_scene removes unused values only; recreate the in-use material set after cleanup.
SKIN = make_material("Corley | cold-weather skin", (0.28, 0.16, 0.13), 0.58)
TANK = make_material("Corley | worn dark tank", (0.155, 0.17, 0.15), 0.96)
TANK_EDGE = make_material("Corley | frayed tank binding", (0.24, 0.25, 0.22), 0.96)
TROUSERS = make_material("Corley | prison medical trousers", (0.34, 0.35, 0.31), 0.97)
TROUSER_SEAM = make_material("Corley | exposed trouser seams", (0.20, 0.22, 0.21), 0.90)
SHOE = make_material("Corley | worn canvas slip-ons", (0.085, 0.09, 0.084), 0.97)
SOLE = make_material("Corley | thin damaged soles", (0.048, 0.053, 0.051), 0.98)
HAIR = make_material("Corley | dark auburn hair", (0.095, 0.047, 0.032), 0.54)
HAIR_LIGHT = make_material("Corley | auburn strand variation", (0.16, 0.073, 0.043), 0.62)
EYE = make_material("Corley | deep green eyes", (0.045, 0.12, 0.095), 0.35)
EYE_WHITE = make_material("Corley | eye white", (0.45, 0.39, 0.34), 0.52)
SCAR = make_material("Corley | healed scar", (0.62, 0.34, 0.26), 0.8)
METAL = make_material("Corley | small silver earring", (0.38, 0.40, 0.39), 0.3, 0.72)
PATCH = make_material("Corley | worn medical patch", (0.29, 0.28, 0.24), 0.94)

RIG = create_rig()
make_limbs()
make_head_and_hair()
make_animations()
export_glb()
print("Generated original Corley character:", OUT)
