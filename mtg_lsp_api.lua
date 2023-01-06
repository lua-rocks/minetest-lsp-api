---@meta
---@diagnostic disable: duplicate-set-field
-- luacheck: ignore

-- Type definitions for Minetest API
-- Initially forked from https://github.com/grapereader/minetest-api-types
-- and extended using https://github.com/minetest/minetest/tree/master/doc

---@alias SideString '"top"' | '"bottom"' | '"front"' | '"left"' | '"back"' | '"right"'

---@alias SoundSpec string

---@alias ColorSpec Color|string

---Vector-like objects that do not contain the vector metatables (ie. not
---constructed with vector.zero()).
---@class SimpleVec
---@field x number
---@field y number
---@field z number

---Minetest stores 3-dimensional spatial vectors in Lua as tables of 3 coordinates,
---and has a class to represent them (`vector.*`). For
---details on what a spatial vectors is, please refer to
---[Wikipedia](https://en.wikipedia.org/wiki/Euclidean_vector).
---
---Spatial vectors are used for various things, including, but not limited to:
---
---- any 3D spatial vector (x/y/z-directions)
---- Euler angles (pitch/yaw/roll in radians) (Spatial vectors have no real
---  semantic meaning here. Therefore, most vector operations make no sense in this
---  use case.)
---
---Vectors can be indexed with numbers and allow method and operator syntax.
---
---All these forms of addressing a vector `v` are valid: `v[1]`, `v[3]`, `v.x`,
---`v[1] = 42`, `v.y = 13` Note: Prefer letter over number indexing for performance
---and compatibility reasons.
---
---Where `v` is a vector and `foo` stands for any function name, `v:foo(...)` does
---the same as `vector.foo(v, ...)`, apart from deprecated functionality.
---
---`tostring` is defined for vectors, see `vector.to_string`.
---
---The metatable that is used for vectors can be accessed via `vector.metatable`.
---Do not modify it!
---
---All `vector.*` functions allow vectors `{x = X, y = Y, z = Z}` without
---metatables. Returned vectors always have a metatable set.
---
---### Operators:
---
---- `v1 == v2`:
---  - Returns whether `v1` and `v2` are identical.
---- `-v`:
---  - Returns the additive inverse of v.
---- `v1 + v2`:
---  - Returns the sum of both vectors.
---  - Note: `+` can not be used together with scalars.
---- `v1 - v2`:
---  - Returns the difference of `v1` subtracted by `v2`.
---  - Note: `-` can not be used together with scalars.
---- `v * s` or `s * v`:
---  - Returns `v` scaled by `s`.
---- `v / s`:
---  - Returns `v` scaled by `1 / s`.
---@class Vector
---@field x number
---@field y number
---@field z number
vector = {}

---- **Deprecated**: `vector.new()` does the same as `vector.zero()` and
---  `vector.new(v)` does the same as `vector.copy(v)`
---@param v Vector|nil
---@return Vector
function vector.new(v) end

---- Returns a new vector `(0, 0, 0)`.
---@return Vector
function vector.zero() end

---- Returns a copy of the vector `v`.
---@param v Vector
---@return Vector
function vector.copy(v) end

---- Returns `v, np`, where `v` is a vector read from the given string `s` and
---`np` is the next position in the string after the vector.
---- Returns `nil` on failure.
---- `s`: Has to begin with a substring of the form `"(x, y, z)"`. Additional
---spaces, leaving away commas and adding an additional comma to the end is
---allowed.
---- `init`: If given starts looking for the vector at this string index.
---@param s string
---@param init integer|nil
---@return Vector|nil
---@return integer|nil next
function vector.from_string(s, init) end

---- Returns a string of the form `"(x, y, z)"`.
---- `tostring(v)` does the same.
---@param v Vector
---@return string
function vector.to_string(v) end

---- Returns a vector of length 1 with direction `p1` to `p2`.
---- If `p1` and `p2` are identical, returns `(0, 0, 0)`.
---@param p1 Vector
---@param p2 Vector
---@return Vector
function vector.direction(p1, p2) end

---- Returns zero or a positive number, the distance between `p1` and `p2`.
---@param p1 Vector
---@param p2 Vector
---@return number
function vector.distance(p1, p2) end

---- Returns zero or a positive number, the length of vector `v`.
---@param v Vector
---@return number
function vector.length(v) end

---- Returns a vector of length 1 with direction of vector `v`.
---- If `v` has zero length, returns `(0, 0, 0)`.
---@param v Vector
---@return Vector
function vector.normalize(v) end

---- Returns a vector, each dimension rounded down.
---@param v Vector
---@return Vector
function vector.floor(v) end

---- Returns a vector, each dimension rounded to nearest integer.
---- At a multiple of 0.5, rounds away from zero.
---@param v Vector
---@return Vector
function vector.round(v) end

---- Returns a vector where the function `func` has been applied to each
---  component.
---@param v Vector
---@param func fun(comp: number): number
function vector.apply(v, func) end

---- Returns a vector where the function `func` has combined both components of
---`v` and `w` for each component
---@param v Vector
---@param w Vector
---@param func function
---@return Vector
function vector.combine(v, w, func) end

---- Returns `true` if the vectors are identical.
---@param v1 Vector
---@param v2 Vector
---@return boolean
function vector.equals(v1, v2) end

---- Returns the dot product of `v1` and `v2`.
---@param v1 Vector
---@param v2 Vector
---@return Vector
function vector.dot(v1, v2) end

---- Returns the cross product of `v1` and `v2`.
---@param v1 Vector
---@param v2 Vector
---@return Vector
function vector.cross(v1, v2) end

---- Returns the sum of the vectors `v` and `(x, y, z)`.
---@param v Vector
---@param x number
---@param y number
---@param z number
function vector.offset(v, x, y, z) end

---- Returns a boolean value indicating whether `v` is a real vector, eg. created
---by a `vector.*` function.
---- Returns `false` for anything else, including tables like `{x=3,y=1,z=4}`.
---@param v Vector
---@return boolean
function vector.check(v) end

---- If `x` is a vector: Returns the difference of `v` subtracted by `x`.
---- If `x` is a number: Subtracts `x` from each component of `v`.
---@param v Vector
---@param x Vector|number
---@return Vector
function vector.subtract(v, x) end

---- Returns in order minp, maxp vectors of the cuboid defined by `v1`, `v2`.
---@param v1 Vector
---@param v2 Vector
---@return Vector, Vector
function vector.sort(v1, v2) end

---- Returns the angle between `v1` and `v2` in radians.
---@param v1 Vector
---@param v2 Vector
---@return number
function vector.angle(v1, v2) end

---- If `x` is a vector: Returns the sum of `v` and `x`.
---- If `x` is a number: Adds `x` to each component of `v`.
---@param v Vector
---@param x Vector|number
---@return Vector
function vector.add(v, x) end

---- Returns a scaled vector.
---- **Deprecated**: If `s` is a vector: Returns the Schur product.
---@param v Vector
---@param s Vector|number
---@return Vector
function vector.multiply(v, s) end

---- Returns a scaled vector.
---- **Deprecated**: If `s` is a vector: Returns the Schur quotient.
---@param v Vector
---@param s Vector|number
---@return Vector
function vector.divide(v, s) end

---- Applies the rotation `r` to `v` and returns the result.
---- `vector.rotate(vector.new(0, 0, 1), r)` and
---  `vector.rotate(vector.new(0, 1, 0), r)` return vectors pointing forward and
---  up relative to an entity's rotation `r`.
---@param v Vector
---@param r Vector
---@return Vector
function vector.rotate(v, r) end

---- Returns `v1` rotated around axis `v2` by `a` radians according to the right
---hand rule.
---@param v1 Vector
---@param v2 Vector
---@param a number
---@return Vector
function vector.rotate_around_axis(v1, v2, a) end

---- Returns a rotation vector for `direction` pointing forward using `up` as the
---up vector.
---- If `up` is omitted, the roll of the returned vector defaults to zero.
---- Otherwise `direction` and `up` need to be vectors in a 90 degree angle to
---each other.
---@param direction Vector
---@param up? Vector
---@return Vector
function vector.dir_to_rotation(direction, up)end

---@class Vector2
---@field x number
---@field y number

---@class Color
---@field r number
---@field g number
---@field b number
---@field a number

---@class NoiseParams
---@field offset number
---@field scale number
---@field spread Vector
---@field seed number
---@field octaves number
---@field persistence number

---@class PointedThing
---@field type '"nothing"'|'"node"'|'"object"'
---@field under? Vector
---@field above? Vector
---@field ref? AnyObjectRef

---@class Raycast
---@param pos1 Vector
---@param pos2 Vector
---@param objects boolean
---@param liquids boolean
---@return Raycast
function Raycast(pos1, pos2, objects, liquids) end

---@return PointedThing pointed_thing
function Raycast:next() end

---@class SecureRandom
---@return SecureRandom
function SecureRandom() end

---@param count? integer Default 1
---@return string
function SecureRandom:next_bytes(count) end

---@class Settings
---@param filename string
---@return Settings
function Settings(filename) end

---@param key string
---@return any value
function Settings:get(key) end

---@param key string
---@param default? boolean
---@return boolean|nil
function Settings:get_bool(key, default) end

---@param key string
---@return NoiseParams
function Settings:get_np_group(key) end

---@param key string
---@return table
function Settings:get_flags(key) end

---@param key string
---@param value any
function Settings:set(key, value) end

---@param key string
---@param value boolean
function Settings:set_bool(key, value) end

---@param key string
---@param value NoiseParams
function Settings:set_np_group(key, value) end

---@param key string
---@return boolean success
function Settings:remove(key) end

---@return string[]
function Settings:get_names() end

---@return boolean success
function Settings:write() end

---@return table
function Settings:to_table() end

---@class PseudoRandom
---@param seed number
---@return PseudoRandom
function PseudoRandom(seed) end

---@param min integer|nil
---@param max integer|nil
---@return integer
function PseudoRandom:next(min, max) end

---@class PcgRandom
---@param seed any
---@param sequence any
---@return PcgRandom
function PcgRandom(seed, sequence) end

---@param min integer|nil
---@param max integer|nil
function PcgRandom:next(min, max) end

---@param min integer
---@param max integer
---@param num_trials? number Default 6
function PcgRandom:rand_normal_dist(min, max, num_trials) end

---@class PerlinNoise
---@param noiseparams table
---@return PerlinNoise
function PerlinNoise(noiseparams) end

---@param pos Vector2
---@return number
function PerlinNoise:get_2d(pos) end

---@param pos Vector
---@return number
function PerlinNoise:get_3d(pos) end

---@class PerlinNoiseMap
---@param noiseparams table
---@param size Vector|Vector2
---@return PerlinNoiseMap
function PerlinNoiseMap(noiseparams, size) end

---@param pos Vector2
---@return number[][]
function PerlinNoiseMap:get_2d_map(pos) end

---@param pos Vector
---@return number[][][]
function PerlinNoiseMap:get_3d_map(pos) end

---@param pos Vector2
---@param buffer any
---@return number[]
function PerlinNoiseMap:get_2d_map_flat(pos, buffer) end

---@param pos Vector
---@param buffer any
---@return number[]
function PerlinNoiseMap:get_3d_map_flat(pos, buffer) end

---@param pos Vector2
function PerlinNoiseMap:calc_2d_map(pos) end

---@param pos Vector
function PerlinNoiseMap:calc_3d_map(pos) end

---@param slice_offset Vector
---@param slice_size Vector
---@param buffer any
---@return number[]
function PerlinNoiseMap:get_map_slice(slice_offset, slice_size, buffer) end

---@class HttpApiTable
local HttpApiTable = {}

---@alias HttpRequestCallback fun(res: HttpRequestResultDefn)

---@param req HttpRequestDefn
---@param callback HttpRequestCallback
function HttpApiTable.fetch(req, callback) end

---@param req HttpRequestDefn
---@return any handle
function HttpApiTable.fetch_async(req) end

---@param handle any
---@return HttpRequestResultDefn
function HttpApiTable.fetch_async_get(handle) end

---@class VoxelManip
local VoxelManip = {}

---@param p1 Vector
---@param p2 Vector
---@return Vector pmin, Vector pmax
function VoxelManip:read_from_map(p1, p2) end

---@param light? boolean
function VoxelManip:write_to_map(light) end

---@param pos Vector
---@return MapNode
function VoxelManip:get_node_at(pos) end

---@param pos Vector
---@param node MapNode
function VoxelManip:set_node_at(pos, node) end

---@param buffer? number[]
---@return number[]
function VoxelManip:get_data(buffer) end

---@param data number[]
function VoxelManip:set_data(data) end

function VoxelManip:update_map() end

---@param light { day: integer, night: integer }
---@param p1? Vector
---@param p2? Vector
function VoxelManip:set_lighting(light, p1, p2) end

---@return integer[]
function VoxelManip:get_light_data() end

---@param data integer[]
function VoxelManip:set_light_data(data) end

---@param buffer? integer[]
---@return integer[]
function VoxelManip:get_param2_data(buffer) end

---@param data integer[]
function VoxelManip:set_param2_data(data) end

---@param p1? Vector
---@param p2? Vector
---@param propagate_shadow? boolean
function VoxelManip:calc_lighting(p1, p2, propagate_shadow) end

function VoxelManip:update_liquids() end

---@return boolean
function VoxelManip:was_modified() end

---@return Vector pmin, Vector pmax
function VoxelManip:get_emerged_area() end

---@class AreaStore
local AreaStore = {}

---@param id integer
---@param include_borders boolean
---@param include_data boolean
---@return nil|'true'|{ min: Vector, max: Vector, data: string } `nil` - Area not found, `true` -- Without `include_borders` and `include_data`
function AreaStore:get_area(id, include_borders, include_data) end

---@param pos Vector
---@param include_borders boolean
---@param include_data boolean
---@return { min: Vector, max: Vector, data: string }[]
function AreaStore:get_areas_for_pos(pos, include_borders, include_data) end

---@param edge1 Vector
---@param edge2 Vector
---@param accept_overlap boolean
---@param include_borders boolean
---@param include_data boolean
---@return { min: Vector, max: Vector, data: string }[]
function AreaStore:get_areas_in_area(
  edge1,
  edge2,
  accept_overlap,
  include_borders,
  include_data
)
  return {}
end

---@param edge1 Vector
---@param edge2 Vector
---@param data string
---@param id? integer
function AreaStore:insert_area(edge1, edge2, data, id) end

---@param count integer
function AreaStore:reserve(count) end

---@param id integer
---@return boolean success
function AreaStore:remove_area(id) end

---@param params { enabled: boolean, block_radius: integer, limit: integer }
function AreaStore:set_cache_params(params) end

---@return string serial Binary string
function AreaStore:to_string() end

---@param filename string
function AreaStore:to_file(filename) end

---@param str string
function AreaStore:from_string(str) end

---@param filename string
function AreaStore:from_file(filename) end

---@class MetaDataRef
local MetaDataRef = {}

---@param key string
---@return boolean
function MetaDataRef:contains(key) end

---@param key string
---@return string|nil
function MetaDataRef:get(key) end

---@param key string
---@param value string Empty string removes key
function MetaDataRef:set_string(key, value) end

---@param key string
---@return string value Empty string if key not present
function MetaDataRef:get_string(key) end

---@param key string
---@param value integer
function MetaDataRef:set_int(key, value) end

---@param key string
---@return integer value 0 if key does not exist
function MetaDataRef:get_int(key) end

---@param key string
---@param value number
function MetaDataRef:set_float(key, value) end

---@param key string
---@return integer
function MetaDataRef:get_float(key) end

---@return table
function MetaDataRef:to_table() end

---@param source table|nil Clears metadata if non-table
---@return boolean success
function MetaDataRef:from_table(source) end

---@param other MetaDataRef
---@return boolean
function MetaDataRef:equals(other) end

---@class StorageRef : MetaDataRef
local StorageRef = {}

---@class NodeMetaRef : MetaDataRef
local NodeMetaRef = {}

---@return InvRef
function NodeMetaRef:get_inventory() end

---Mark specific vars as private. This will prevent them from being sent to the client. Note that the "private" status will only be remembered if an associated key-value pair exists, meaning it's best to call this when initializing all other meta (e.g. `on_construct`).
---@param name string|string[]
function NodeMetaRef:mark_as_private(name) end

---@class NodeTimerRef
local NodeTimerRef = {}

---@param timeout number
---@param elapsed number
function NodeTimerRef:set(timeout, elapsed) end

---@param timeout number
function NodeTimerRef:start(timeout) end

function NodeTimerRef:stop() end

---@return integer
function NodeTimerRef:get_timeout() end

---@return integer
function NodeTimerRef:get_elapsed() end

---@return boolean
function NodeTimerRef:is_started() end

---@class ItemStackMetaRef : MetaDataRef
local ItemStackMetaRef = {}

---@param tool_capabilities? ToolCapabilities Clears override data when nil
function ItemStackMetaRef:set_tool_capabilities(tool_capabilities) end

---@class ItemStack
local ItemStack = {}

---@return boolean
function ItemStack:is_empty() end

---@return string name (ie: 'default:stone')
function ItemStack:get_name() end

---@param item_name string
---@return boolean cleared
function ItemStack:set_name(item_name) end

---@return number
function ItemStack:get_count() end

---@param count number
---@return boolean cleared
function ItemStack:set_count(count) end

---@return number
function ItemStack:get_wear() end

---@param wear number
---@return boolean cleared
function ItemStack:set_wear(wear) end

---@return ItemStackMetaRef
function ItemStack:get_meta() end

---@return string
function ItemStack:get_description() end

---@return string
function ItemStack:get_short_description() end

function ItemStack:clear() end

function ItemStack:replace(item) end

---@return string
function ItemStack:to_string() end

---@return table
function ItemStack:to_table() end

---@return number
function ItemStack:get_stack_max() end

---@return number
function ItemStack:get_free_space() end

---@return boolean
function ItemStack:is_known() end

---@return table
function ItemStack:get_definition() end

---@return ToolCapabilities
function ItemStack:get_tool_capabilities() end

---@param amount number
function ItemStack:add_wear(amount) end

---@param item ItemStack
---@return ItemStack leftover
function ItemStack:add_item(item) end

---@param item ItemStack
---@return boolean
function ItemStack:item_fits(item) end

---@param n number
---@return ItemStack taken
function ItemStack:take_item(n) end

---@param n number
---@return ItemStack taken
function ItemStack:peek_item(n) end

---@class InvRef
local InvRef = {}

---@param listname string
---@return boolean
function InvRef:is_empty(listname) end

---@param listname string
---@return integer
function InvRef:get_size(listname) end

---@param listname string
---@param size integer
---@return boolean success
function InvRef:set_size(listname, size) end

---@param listname string
---@return integer
function InvRef:get_width(listname) end

---@param listname string
---@param width integer
function InvRef:set_width(listname, width) end

---@param listname string
---@param index integer
---@return ItemStack
function InvRef:get_stack(listname, index) end

---@param listname string
---@param index integer
---@param stack ItemStack
function InvRef:set_stack(listname, index, stack) end

---@param listname string
---@return any list TODO return type
function InvRef:get_list(listname) end

---@param listname string
---@param list any TODO type
function InvRef:set_list(listname, list) end

---@return any[] lists
function InvRef:get_lists() end

---@param lists any[]
function InvRef:set_lists(lists) end

---@param listname string
---@param stack ItemStack
---@return ItemStack leftover
function InvRef:add_item(listname, stack) end

---@param listname string
---@param stack ItemStack
---@return boolean is_room
function InvRef:room_for_item(listname, stack) end

---@param listname string
---@param stack ItemStack
---@param match_meta boolean Only compares names if unset
function InvRef:contains_item(listname, stack, match_meta) end

---Take as many items as specified from the list, returns the items that were actually removed (as an `ItemStack`) -- note that any item metadata is ignored, so attempting to remove a specific unique item this way will likely remove the wrong one -- to do that use `set_stack` with an empty `ItemStack`.
---@param listname string
---@param stack ItemStack
---@return ItemStack
function InvRef:remove_item(listname, stack) end

---returns a location compatible to `minetest.get_inventory(location)`. returns `{type="undefined"}` in case location is not known
---@return any
function InvRef:get_location() end

---@class PlayerMetaRef : MetaDataRef
local PlayerMetaRef = {}

---@class ToolGroupEntry
---@field maxlevel integer Indicates the maximum level of a node of this group that the item will be able to dig.
---@field uses integer
---@field times number[] List of digging times for different ratings of the group, for nodes of the maximum level. For example, as a Lua table, `times={2=2.00, 3=0.70}`. This would result in the item to be able to dig nodes that have a rating of `2` or `3` for this group, and unable to dig the rating `1`, which is the toughest. Unless there is a matching group that enables digging otherwise. If the result digging time is 0, a delay of 0.15 seconds is added between digging nodes; If the player releases LMB after digging, this delay is set to 0, i.e. players can more quickly click the nodes away instead of holding LMB.
local ToolGroupEntry = {}

---@class ToolCapabilities
---@field full_punch_interval number When used as a weapon, the item will do full damage if this time is spent between punches. If e.g. half the time is spent, the item will do half damage.
---@field max_drop_level integer Suggests the maximum level of node, when dug with the item, that will drop its useful item. (e.g. iron ore to drop a lump of iron). This is not automated; it is the responsibility of the node definition to implement this.
---@field groupcaps table<string, ToolGroupEntry>
---@field damage_groups table<string, number>
---@field punch_attack_uses integer | nil
local ToolCapabilities = {}

---@class ObjectRef
local ObjectRef = {}
---@return Vector
function ObjectRef:get_pos() end

---@param pos Vector
function ObjectRef:set_pos(pos) end

---@return Vector
function ObjectRef:get_velocity() end

---@param vel Vector
function ObjectRef:add_velocity(vel) end

---@param pos Vector
---@param continuous? boolean
function ObjectRef:move_to(pos, continuous) end

---@param puncher ObjectRef
---@param time_from_last_punch any time since last punch action of the puncher
---@param tool_capabilities ToolCapabilities
---@param direction any Can be nil
function ObjectRef:punch(
  puncher,
  time_from_last_punch,
  tool_capabilities,
  direction
)
end

---@param clicker ObjectRef
function ObjectRef:right_click(clicker) end

---@return number
function ObjectRef:get_hp() end

---@param hp number limited to the range of 0 ... 65535 (2^16 - 1)
---@param reason? string
function ObjectRef:set_hp(hp, reason) end

---@return InvRef
function ObjectRef:get_inventory() end

---@return string
function ObjectRef:get_wield_list() end

---@return number
function ObjectRef:get_wield_index() end

---@return ItemStack
function ObjectRef:get_wielded_item() end

---@param item ItemStack
---@return boolean true if successful
function ObjectRef:set_wielded_item(item) end

---@param group_table table {group1=rating, group2=rating, ...}
function ObjectRef:set_armor_groups(group_table) end

---@return table {group1=rating, group2=rating, ...}
function ObjectRef:get_armor_groups() end

---@param frame_range { x: number, y: number }
---@param frame_speed number
---@param frame_blend number
---@param frame_loop boolean
function ObjectRef:set_animation(
  frame_range,
  frame_speed,
  frame_blend,
  frame_loop
)
end

---@return { x: number, y: number} range, number frame_speed, number frame_blend, boolean frame_loop
function ObjectRef:get_animation() end

---@param frame_speed number
function ObjectRef:set_animation_frame_speed(frame_speed) end

---@param parent any
---@param bone? string
---@param position? Vector
---@param rotation? Vector
---@param forced_visible? boolean
function ObjectRef:set_attach(
  parent,
  bone,
  position,
  rotation,
  forced_visible
)
end

---@return any parent, string bone, Vector position, Vector rotation, boolean forced_visible
function ObjectRef:get_attach() end

---@return ObjectRef[]
function ObjectRef:get_children() end

function ObjectRef:set_detach() end

---@param bone? string
---@param position? Vector
---@param rotation? Vector
function ObjectRef:set_bone_position(bone, position, rotation) end

---@param bone string
---@return Vector position, Vector rotation
function ObjectRef:get_bone_position(bone) end

---@param property_table table
function ObjectRef:set_properties(property_table) end

---@return table
function ObjectRef:get_properties() end

---@return { text: string, color: ColorSpec, bgcolor: ColorSpec }
function ObjectRef:get_nametag_attributes() end

---@param attrs { text: string, color: ColorSpec, bgcolor: ColorSpec }
function ObjectRef:set_nametag_attributes(attrs) end

---@class LuaObjectRef : ObjectRef
local LuaObjectRef = {}

---The object is removed after returning from Lua. However the `ObjectRef`
---itself instantly becomes unusable with all further method calls having
---no effect and returning `nil`.
function LuaObjectRef:remove() end

---@param vel Vector
function LuaObjectRef:set_velocity(vel) end

---@param acc Vector
function LuaObjectRef:set_acceleration(acc) end

---@return Vector
function LuaObjectRef:get_acceleration() end

---@param rot Vector
function LuaObjectRef:set_rotation(rot) end

---@return Vector
function LuaObjectRef:get_rotation() end

---@param yaw number
function LuaObjectRef:set_yaw(yaw) end

---@return number
function LuaObjectRef:get_yaw() end

---TODO Docs
function LuaObjectRef:set_texture_mod(mod) end

---TODO Docs
function LuaObjectRef:get_texture_mod() end

---@param start_frame {x: number, y: number} The coordinate of the first frame
---@param num_frames number Total frames in the tecture
---@param framelength number Time per animated frame in seconds
---@param select_x_by_camera boolean Only for visual = `sprite`. Changes the frame `x` position according to the view direction. default: `false`.
function LuaObjectRef:set_sprite(
  start_frame,
  num_frames,
  framelength,
  select_x_by_camera
)
end

---@deprecated
function LuaObjectRef:get_entity_name() end

---@return any
function LuaObjectRef:get_luaentity() end

---@class PlayerObjectRef : ObjectRef
local PlayerObjectRef = {}

---@return string
function PlayerObjectRef:get_player_name() end

---@return Vector
function PlayerObjectRef:get_look_dir() end

---@return number
function PlayerObjectRef:get_look_vertical() end

---@return number
function PlayerObjectRef:get_look_horizontal() end

---@param radians number
function PlayerObjectRef:set_look_vertical(radians) end

---@param radians number
function PlayerObjectRef:set_look_horizontal(radians) end

---@return number
function PlayerObjectRef:get_breath() end

---@param value number
function PlayerObjectRef:set_breath(value) end

---@param fov number FOV value
---@param is_multiplier boolean Set to `true` if the FOV value is a multiplier. Defaults to `false`.
---@param transition_time number If defined, enables smooth FOV transition. Interpreted as the time (in seconds) to reach target FOV. If set to 0, FOV change is instantaneous. Defaults to 0.
function PlayerObjectRef:set_fov(fov, is_multiplier, transition_time) end

---@return number fov, boolean is_multiplier, number transition_time
function PlayerObjectRef:get_fov() end

---@return PlayerMetaRef
function PlayerObjectRef:get_meta() end

--- @param formspec string
function PlayerObjectRef:set_inventory_formspec(formspec) end

--- @return string
function PlayerObjectRef:get_inventory_formspec() end

--- @param formspec string
function PlayerObjectRef:set_formspec_prepend(formspec) end

--- @param formspec string
function PlayerObjectRef:get_formspec_prepend(formspec) end

--- @return { up: boolean, down: boolean, left: boolean, right: boolean, jump: boolean, aux1: boolean, sneak: boolean, dig: boolean, place: boolean, LMB: boolean, RMB: boolean, zoom: boolean }
function PlayerObjectRef:get_player_control() end

---@return number
function PlayerObjectRef:get_player_control_bits() end

--- @param override_table { speed: number, jump: number, gravity: number, sneak: boolean, sneak_glitch: boolean, new_move: boolean }
function PlayerObjectRef:set_physics_override(override_table) end

--- @return { speed: number, jump: number, gravity: number, sneak: boolean, sneak_glitch: boolean, new_move: boolean }
function PlayerObjectRef:get_physics_override() end

---@param definition HudDefn
---@return number id on success
function PlayerObjectRef:hud_add(definition) end

---@param id number
function PlayerObjectRef:hud_remove(id) end

---@param id number
---@param stat '"position"'|'"name"'|'"scale"'|'"text"'|'"number"'|'"item"'|'"dir"'
---@param value any
function PlayerObjectRef:hud_change(id, stat, value) end

---@param id number
function PlayerObjectRef:hud_get(id) end

---@param flags { hotbar: boolean, healthbar: boolean, crosshair: boolean, wielditem: boolean, breathbar: boolean, minimap: boolean, minimap_radar: boolean } If a flag is `nil`, the flag is not modified
function PlayerObjectRef:hud_set_flags(flags) end

---@return { hotbar: boolean, healthbar: boolean, crosshair: boolean, wielditem: boolean, breathbar: boolean, minimap: boolean, minimap_radar: boolean }
function PlayerObjectRef:hud_get_flags() end

---@param count number
function PlayerObjectRef:hud_set_hotbar_itemcount(count) end

---@return number
function PlayerObjectRef:hud_get_hotbar_itemcount() end

---@param texturename string
function PlayerObjectRef:hud_set_hotbar_image(texturename) end

---@return string
function PlayerObjectRef:hud_get_hotbar_image() end

---@param texturename string
function PlayerObjectRef:hud_set_hotbar_selected_image(texturename) end

---@return string
function PlayerObjectRef:hud_get_hotbar_selected_image() end

---@class MiniMapMode
---@field type '"off"'|'"surface"'|'"radar"'|'"texture"'
---@field label string
---@field size number Side length or diameter in nodes
---@field texture string
---@field scale number Only for texture type
local MiniMapMode = {}

---@param modes MiniMapMode[]
---@param selected_mode number Mode index to be selected after change (starting at 0)
function PlayerObjectRef:set_minimap_modes(modes, selected_mode) end

---@class SkyParameters
---@field base_color? ColorSpec
---@field type? string `regular` uses 0 textures, base color ignored, `skybox` uses 6 textures, base color as fog, `plain` uses 0 textures, base color as sky and fog
---@field textures? string[] A table containing up to six textures in the following order: Y+ (top), Y- (bottom), X- (west), X+ (east), Z+ (north), Z- (south).
---@field clouds? boolean
---@field sky_color? { day_sky: ColorSpec, day_horizon: ColorSpec, dawn_sky: ColorSpec, dawn_horizon: ColorSpec, night_sky: ColorSpec, night_horizon: ColorSpec, indoors: ColorSpec, fog_sun_tint: ColorSpec, fog_moon_tint: ColorSpec, fog_tint_type: string }
local SkyParameters = {}

---@param sky_parameters SkyParameters
function PlayerObjectRef:set_sky(sky_parameters) end

---@return ColorSpec base_color, string type, string[] textures, boolean clouds
function PlayerObjectRef:get_sky() end

---@class SunParameters
---@field visible? boolean
---@field texture? string
---@field tonemap? string
---@field sunrise? string
---@field sunrise_visible? boolean
---@field scale number
local SunParameters = {}

---@param sun_parameters SunParameters
function PlayerObjectRef:set_sun(sun_parameters) end

---@return SunParameters
function PlayerObjectRef:get_sun() end

---@class MoonParameters
---@field visible? boolean
---@field texture? string
---@field tonemap? string
---@field scale? number
local MoonParameters = {}

---@param moon_parameters MoonParameters
function PlayerObjectRef:set_moon(moon_parameters) end

---@return MoonParameters
function PlayerObjectRef:get_moon() end

---@class StarParameters
---@field visible? boolean
---@field count? number
---@field star_color? ColorSpec
---@field scale? number
local StarParameters = {}

---@param star_parameters StarParameters
function PlayerObjectRef:set_stars(star_parameters) end

---@return StarParameters
function PlayerObjectRef:get_stars() end

---@class CloudParameters
---@field density? number
---@field color? ColorSpec
---@field ambient? ColorSpec
---@field height? number
---@field thickness? number
---@field speed? { x: number, z: number }
local CloudParameters = {}

---@param cloud_parameters CloudParameters
function PlayerObjectRef:set_clouds(cloud_parameters) end

---@return CloudParameters
function PlayerObjectRef:get_clouds() end

---@param ratio number | nil Ratio from 0...1
function PlayerObjectRef:override_day_night_ratio(ratio) end

---@return number | nil ratio Ratio from 0...1, `nil` if not overridden
function PlayerObjectRef:get_day_night_ratio() end

---@param idle Vector2
---@param walk Vector2
---@param dig  Vector2
---@param walk_while_dig Vector2
---@param frame_speed number
function PlayerObjectRef:set_local_animation(
  idle,
  walk,
  dig,
  walk_while_dig,
  frame_speed
)
end
---@return Vector2 idle, Vector2 walk, Vector2 dig, Vector2 walk_while_dig, number frame_speed
function PlayerObjectRef:get_local_animation() end

--- Arguments default to 0,0,0 if unspecified
---@param firstperson? Vector
---@param thirdperson? Vector
function PlayerObjectRef:set_eye_offset(firstperson, thirdperson) end

--- Sends a serverside loaded mapblock to the player. Resource intensive, use sparingly
---@param blockpos any
---@return boolean result false if failed
function PlayerObjectRef:send_mapblock(blockpos) end

---@alias AnyObjectRef ObjectRef|PlayerObjectRef|LuaObjectRef

-- ! Definition tables

---@class ObjectPropertiesDefn
---@field hp_max integer
---@field breath_max integer
---@field zoom_fov number
---@field eye_height number
---@field physical boolean
---@field collide_with_objects boolean
---@field collisionbox number[]
---@field selectionbox number[]
---@field visual_size Vector
---@field mesh string
---@field textures string[]
---@field colors string[]
---@field use_texture_alpha boolean
---@field spritediv Vector2
---@field initial_sprite_basepos Vector2
---@field is_visible boolean
---@field makes_footstep_sound boolean
---@field automatic_rotate number
---@field stepheight number
---@field automatic_face_movement_dir number
---@field automatic_face_movement_max_rotation_per_sec number
---@field backface_culling boolean
---@field glow number
---@field nametag string
---@field nametag_color ColorSpec
---@field nametag_bgcolor ColorSpec
---@field infotext string
---@field static_save boolean
---@field damage_texture_modifier string
---@field shaded boolean
---@field show_on_minimap boolean
local ObjectPropertiesDefn = {}

---@class CollisionInfoDefn
---@field touching_ground boolean
---@field collides boolean
---@field standing_on_object boolean
---@field collisions { type: '"node"' | '"object"', axis: '"x"' | '"y"' | '"z"', node_pos: Vector, object: ObjectRef, old_velocity: Vector, new_velocity: Vector }[]
local CollisionInfoDefn = {}

---@class EntityDefn
---@field initial_properties ObjectPropertiesDefn
---@field on_activate fun(self: any, staticdata: any, dtime_s: number): nil
---@field on_step fun(self: any, dtime: number, moveresult: CollisionInfoDefn): nil
---@field on_punch fun(self: any, puncher: AnyObjectRef, time_from_last_punch: number, tool_capabilities: ToolCapabilities, dir: any): nil
---@field on_rightclick fun(self: any, clicker: AnyObjectRef): nil
---@field get_staticdata fun(self: any): string Called sometimes; the string returned is passed to on_activate when the entity is re-activated from static state
local EntityDefn = {}

---@class ABMDefn
---@field label string Descriptive label for profiling purposes (optional). Definitions with identical labels will be listed as one.
---@field nodenames string[] Apply `action` function to these nodes. `group:groupname` can also be used here.
---@field neighbors string[] Only apply `action` to nodes that have one of, or any combination of, these neighbors. If left out or empty, any neighbor will do. `group:groupname` can also be used here.
---@field interval number Operation interval in seconds
---@field change number Chance of triggering `action` per-node per-interval is 1.0 / this value
---@field min_x integer Min height level where ABM will be processed can be used to reduce CPU usage
---@field max_y integer Max height level where ABM will be processed can be used to reduce CPU usage
---@field catch_up boolean If true, catch-up behaviour is enabled: The `chance` value is temporarily reduced when returning to an area to simulate time lost by the area being unattended. Note that the `chance` value can often be reduced to 1.
---@field action fun(pos: Vector, node: any, active_object_count: integer, active_object_count_wider: integer) Function triggered for each qualifying node. `active_object_count` is number of active objects in the node's mapblock. `active_object_count_wider` is number of active objects in the node's mapblock plus all 26 neighboring mapblocks. If any neighboring mapblocks are unloaded an estmate is calculated for them based on loaded mapblocks.
local ABMDefn = {}

---@class LBMDefn
---@field label string Descriptive label for profiling purposes (optional). Definitions with identical labels will be listed as one.
---@field name string
---@field nodenames string[] List of node names to trigger the LBM on. Also non-registered nodes will work. Groups (as of group:groupname) will work as well.
---@field run_at_every_load boolean Whether to run the LBM's action every time a block gets loaded, and not only the first time the block gets loaded after the LBM was introduced.
---@field action fun(pos: Vector, node: any): nil
local LBMDefn = {}

---@class VFTileAnimDefn
---@field type '"vertical_frames"'
---@field aspect_w integer
---@field aspect_h integer
---@field length number
local VFTileAnimDefn = {}

---@class S2DTileAnimDefn
---@field frames_w integer
---@field frames_h integer
---@field frames_length number
local S2DTileAnimDefn = {}

---@alias TileAnimDefn VFTileAnimDefn|S2DTileAnimDefn

---@class ItemDefn
---@field description string
---@field short_description string
---@field groups table
---@field inventory_image string
---@field inventory_overlay string
---@field wield_image string
---@field wield_overlay string
---@field palette string
---@field color string
---@field wield_scale Vector
---@field stack_max integer
---@field range number
---@field liquids_pointable boolean
---@field light_source integer
---@field tool_capabilities ToolCapabilities
---@field node_placement_prediction string | nil
---@field node_dig_prediction string
---@field sound table
---@field on_place fun(itemstack: ItemStack, placer: AnyObjectRef, pointed_thing: PointedThing): nil
---@field on_secondary_use fun(itemstack: ItemStack, user: AnyObjectRef|nil, pointed_thing: PointedThing): nil
---@field on_drop fun(itemstack: ItemStack, dropper: AnyObjectRef|nil, pos: Vector): nil
---@field on_use fun(itemstack: ItemStack, user: AnyObjectRef|nil, pointed_thing: PointedThing): nil
---@field after_use fun(itemstack: ItemStack, user: AnyObjectRef|nil, node: any, digparams: table): nil
---@field type string
local ItemDefn = {}

---@class NodeDefn
---@field drawtype string
---@field visual_scale number
---@field tiles string[]
---@field overlay_tiles string[]|table[]
---@field special_tiles string[]|table[]
---@field color ColorSpec
---@field use_texture_alpha '"opaque"'|'"clip"'|'"blend"'
---@field palette string
---@field post_effect_color ColorSpec
---@field paramtype string
---@field paramtype2 string
---@field place_param2 string|nil
---@field is_ground_content boolean
---@field sunlight_propagates boolean
---@field walkable boolean
---@field pointable boolean
---@field diggable boolean
---@field climbable boolean
---@field buildable_to boolean
---@field floodable boolean
---@field liquidtype '"none"'|'"source"'|'"flowing"'
---@field liquid_alternative_flowing string
---@field liquid_alternative_source string
---@field liquid_viscosity integer
---@field liquid_renewable boolean
---@field leveled integer
---@field leveled_max integer
---@field liquid_range integer
---@field drowning integer
---@field damage_per_second integer
---@field node_box table
---@field connects_to string[]
---@field connect_sides SideString[]
---@field mesh string
---@field selection_box table
---@field collision_box table
---@field legacy_facedir_simple boolean
---@field legacy_wallmounted boolean
---@field waving integer
---@field sounds { footstep: SoundSpec, dig: SoundSpec, dug: SoundSpec, place: SoundSpec, place_failed: SoundSpec, fall: SoundSpec }
---@field drop string | { max_items: integer, items: table[] }
---@field on_construct fun(pos: Vector): nil
---@field on_destruct fun(pos: Vector): nil
---@field after_destruct fun(pos: Vector, oldnode: any): nil
---@field on_flood fun(pos: Vector, oldnode: any, newnode: any): nil
---@field preserve_metadata fun(pos: Vector, oldnode: any, oldmeta: NodeMetaRef, drops: ItemStack[]): nil
---@field after_place_node fun(pos: Vector, placer: AnyObjectRef|nil, itemstack: ItemStack, pointed_thing: PointedThing): nil
---@field after_dig_node fun(pos: Vector, oldnode: any, oldmetadata: NodeMetaRef, digger: AnyObjectRef|nil): nil
---@field can_dig fun(pos: Vector, player: PlayerObjectRef|nil): nil
---@field on_punch fun(pos: Vector, node: any, puncher: AnyObjectRef, pointed_thing: PointedThing): nil
---@field on_rightclick fun(pos: Vector, node: any, clicker: AnyObjectRef|nil, itemstack: ItemStack, pointed_thing: PointedThing): nil
---@field on_dig fun(pos: Vector, node: any, digger: AnyObjectRef|nil): boolean
---@field on_timer fun(pos: Vector, elapsed: number): boolean
---@field on_receive_fields fun(pos: Vector, formname: string, fields: table, sender: PlayerObjectRef): nil
---@field allow_metadata_inventory_move fun(pos: Vector, from_list: any, from_index: integer, to_list: any, to_index: integer, count: integer, player: PlayerObjectRef): integer
---@field allow_metadata_inventory_put fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): integer
---@field allow_metadata_inventory_take fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): integer
---@field on_metadata_inventory_move fun(pos: Vector, from_list: any, from_index: integer, to_list: any, to_index: integer, count: integer, player: PlayerObjectRef): nil
---@field on_metadata_inventory_put fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): nil
---@field on_metadata_inventory_take fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): nil
---@field on_blast fun(pos: Vector, intensity: number)
---@field mod_origin string
local NodeDefn = {}

---@class CraftShapedDefn
---@field output string
---@field recipe string[][]
---@field replacements string[][]
local CraftShapedDefn = {}

---@class CraftShapelessDefn
---@field type '"shapeless"'
---@field output string
---@field recipe string[]
---@field replacements string[][]
local CraftShapelessDefn = {}

---@class CraftToolRepair
---@field type '"toolrepair"'
---@field additional_wear number
local CraftToolRepair = {}

---@class CraftCooking
---@field type '"cooking"'
---@field output string
---@field recipe string
---@field cooktime integer
local CraftCooking = {}

---@class CraftFurnaceFuel
---@field type '"fuel"'
---@field recipe string
---@field burntime integer
---@field replacements string[][]
local CraftFurnaceFuel = {}

---@alias AnyCraftDefn CraftShapedDefn|CraftShapelessDefn|CraftToolRepair|CraftCooking|CraftFurnaceFuel

---@class OreDefn
---@field ore_type string
---@field ore string
---@field ore_param2 integer
---@field wherein string
---@field clust_scarcity integer
---@field clust_num_ores integer
---@field clust_size integer
---@field y_min integer
---@field y_max integer
---@field flags string
---@field noise_threshold number
---@field noise_params NoiseParams
---@field biomes string[]
---@field column_height_min integer
---@field column_height_max integer
---@field column_height_factor number
---@field np_puff_top NoiseParams
---@field np_puff_bottom NoiseParams
---@field random_factor number
---@field np_stratum_thickness NoiseParams
---@field stratum_thickness integer
local OreDefn = {}

---@class BiomeDefn
---@field name string
---@field node_dust string
---@field node_top string
---@field deapth_top integer
---@field node_filler string
---@field depth_filler integer
---@field node_stone string
---@field node_water_top string
---@field depth_water_top integer
---@field node_water string
---@field node_river_water string
---@field node_riverbed string
---@field depth_riverbed integer
---@field node_cave_liquid string | string[]
---@field node_dungeon string
---@field node_dungeon_alt string
---@field node_dungeon_staor string
---@field y_max integer
---@field y_min integer
---@field max_pos Vector
---@field min_pos Vector
---@field vertical_blend integer
---@field heat_point integer
---@field humidity_point integer
local BiomeDefn = {}

---@class MapNode
---@field name string
---@field prob? number
---@field param2? number
---@field foce_place? boolean
local MapNode = {}

---@class DecorationDefn
---@field deco_type string
---@field place_on string
---@field sidelen integer
---@field fill_ratio number
---@field noise_params NoiseParams
---@field biomes string[]
---@field y_min integer
---@field y_max integer
---@field spawn_by string
---@field num_spawn_by integer
---@field flags string
---@field decoration string
---@field height integer
---@field height_max integer
---@field param2 integer
---@field param2_max integer
---@field place_offset_y integer
---@field schematic string | { size: Vector, data: MapNode[], yslice_prob: { ypos: integer, prob: integer }[] }
---@field replacements table
---@field rotation string
local DecorationDefn = {}

---@class ChatCommandDefn
---@field params string
---@field description string
---@field privs table<string, boolean>
---@field func fun(name: string, param: string): boolean, string
local ChatCommandDefn = {}

---@class PrivilegeDefn
---@field description string
---@field give_to_singleplayer boolean
---@field give_to_admin boolean
---@field on_grant fun(name: string, granter_name: string): boolean Return true to prevent
---@field on_revoke fun(name: string, revoker_name: string): boolean Return true to prevent
local PrivilegeDefn = {}

---@class DetachedInvDefn
---@field allow_move fun(inv: InvRef, from_list: any, from_index: integer, to_list: any, to_index: integer, count: integer, player: PlayerObjectRef): integer
---@field allow_put fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): integer
---@field allow_take fun(pos: Vector, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): integer
---@field on_move fun(pos: Vector, from_list: any, from_index: integer, to_list: any, to_index: integer, count: integer, player: PlayerObjectRef): nil
---@field on_put fun(inv: InvRef, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): nil
---@field on_take fun(inv: InvRef, listname: string, index: integer, stack: ItemStack, player: PlayerObjectRef): nil
local DetachedInvDefn = {}

---@class HudDefn
---@field hud_elem_type string
---@field position Vector2
---@field name string
---@field scale Vector2
---@field text string
---@field text2 string
---@field number integer
---@field item integer
---@field direction integer
---@field alignment Vector2
---@field offset Vector2
---@field size Vector2
---@field z_index integer
---@field style integer
local HudDefn = {}

---@class ParticleDefn
---@field pos Vector
---@field velocity Vector
---@field acceleration Vector
---@field expirationtime number
---@field size number
---@field collisiondetection boolean
---@field collision_removal boolean
---@field object_collision boolean
---@field vertical boolean
---@field texture string
---@field playername? string
---@field animation? TileAnimDefn
---@field glow? integer
---@field node? { name: string, param2: integer }
---@field node_tile? integer
local ParticleDefn = {}

---@class ParticleSpawnerDefn
---@field amount integer
---@field time number
---@field minpos Vector
---@field maxpos Vector
---@field minvel Vector
---@field maxvel Vector
---@field minacc Vector
---@field maxacc Vector
---@field minexptime number
---@field maxexptime number
---@field minsize number
---@field maxsize number
---@field collisiondetection boolean
---@field collision_removal boolean
---@field object_collision boolean
---@field attached ObjectRef
---@field vertical boolean
---@field texture string
---@field playername? string
---@field animation? TileAnimDefn
---@field glow? integer
---@field node? { name: string, param2: integer }
---@field node_tile? integer
local ParticleSpawnerDefn = {}

---@class HttpRequestDefn
---@field url string
---@field method '"GET"'|'"POST"'|'"PUT"'|'"DELETE"'
---@field data? string | table
---@field user_agent? string
---@field extra_headers? string[]
---@field multipart? boolean
local HttpRequestDefn = {}

---@class HttpRequestResultDefn
---@field completed boolean
---@field succeeded boolean
---@field timeout boolean
---@field code integer
---@field data string
local HttpRequestResultDefn = {}

---@class AuthHandlerDefn
---@field get_auth fun(name: string): { password: string, privileges: string, last_login: integer }
---@field create_auth fun(name: string, password: string)
---@field delete_auth fun(name: string): boolean
---@field set_password fun(name: string, password: string): nil
---@field set_privileges fun(name: string, privileges: string): nil
---@field reload fun(): boolean
---@field record_login fun(name: string): nil
---@field iterate fun(): any
local AuthHandlerDefn = {}

---@class SchematicDefn
---@field size Vector
---@field yslice_prob { ypos: number, prob: number }[]
---@field data { name: string, prob: number, param2: number, force_place: boolean }[]
local SchematicDefn = {}

---@class TreeDef
---@field axiom string
---@field rules_a string
---@field rules_b string
---@field rules_c string
---@field rules_d string
---@field trunk string
---@field leaves string
---@field leaves2 string
---@field leaves2_chance number
---@field angle number
---@field iterations integer
---@field random_level number
---@field trunk_type string
---@field thin_branches boolean
---@field fruit string
---@field fruit_chance number
---@field seed number
local TreeDef = {}

-- ! Global tables

minetest = {}

---@type table<string, ItemDefn>
minetest.registered_items = {}

---@type table<string, NodeDefn>
minetest.registered_nodes = {}

---@type table<string, AnyCraftDefn>
minetest.registered_craftitems = {}

---@type table<string, ItemDefn>
minetest.registered_tools = {}

---@type table<string, EntityDefn>
minetest.registered_entities = {}

---@type table<integer, ObjectRef>
minetest.object_refs = {}

---@type table<integer, LuaObjectRef>
minetest.luaentities = {}

---@type ABMDefn[]
minetest.registered_abms = {}

---@type LBMDefn[]
minetest.registered_lbms = {}

---@type table<string, any>
minetest.registered_aliases = {}

---@type table<string, OreDefn>
minetest.registered_ores = {}

---@type table<string, BiomeDefn>
minetest.registered_biomes = {}

---@type table<string, DecorationDefn>
minetest.registered_decorations = {}

---@type table<string, SchematicDefn>
minetest.registered_schematics = {}

---@type table<string, ChatCommandDefn>
minetest.registered_chatcommands = {}

---@type table<string, PrivilegeDefn>
minetest.registered_privileges = {}

-- ! Escape sequences

---@param color string
---@return string
function minetest.get_color_escape_sequence(color) end

---@param color string
---@return string
function minetest.get_background_escape_sequence(color) end

---@param str string
---@return string
function minetest.strip_foreground_colors(str) end

---@param str string
---@return string
function minetest.strip_background_colors(str) end

---@param str string
---@return string
function minetest.strip_colors(str) end

-- ! Helper functions

---@param obj any
---@param name string
---@param dumped table
---@return string
function dump2(obj, name, dumped) end

---@param obj any
---@param dumped table
---@return string
function dump(obj, dumped) end

---@param x number
---@param y number
---@return number
function math.hypot(x, y) end

---- Get the sign of a number.
---- If the absolute value of `x` is within the `tolerance` or `x` is NaN,
--- `0` is returned.
---@param x number
---@param tolerance number|nil `0.0`
---@return number `-1`|`0`|`1`
function math.sign(x, tolerance) end

---@param x number
---@return number
function math.factorial(x) end

---@param x number
---@return number
function math.round(x) end

---@param str string
---@param separator string
---@param max_splits? boolean
function string.split(
  str,
  separator,
  include_empty,
  max_splits,
  sep_is_pattern
)
end

---@return string
function string:trim() end

---@param str string
---@param limit integer
---@param as_table? boolean
---@return string | table
function minetest.wrap_text(str, limit, as_table) end

---@param pos Vector
---@param decimal_places? integer
function minetest.pos_to_string(pos, decimal_places) end

---@param string string
---@return Vector
function minetest.string_to_pos(string) end

---@param string string
---@return Vector, Vector
function minetest.string_to_area(string) end

---@param arg string
---@return boolean
function minetest.is_yes(arg) end

---@param arg number
---@return boolean
function minetest.is_nan(arg) end

---@return number
function minetest.get_us_time() end

---@param table table
---@return table
function table.copy(table) end

---@param list any[]
---@param val any
---@return integer
function table.indexof(list, val) end

---@param table table
---@param other_table table
function table.insert_all(table, other_table) end

---@param t table
---@return table
function table.key_value_swap(t) end

---@param table table
---@param from? integer
---@param to? integer
---@param random_func? fun(a: integer, b: integer): integer
function table.shuffle(table, from, to, random_func) end

---@param placer AnyObjectRef
---@param pointed_thing PointedThing
---@return Vector
function minetest.pointed_thing_to_face_pos(placer, pointed_thing) end

---@param groups table
---@param tool_capabilities ToolCapabilities
---@return { diggable: boolean, time: number, wear: number }
function minetest.get_dig_params(groups, tool_capabilities) end

---@param groups table
---@param tool_capabilities ToolCapabilities
---@param time_from_last_punch? number
---@return { hp: number, wear?: number }
function minetest.get_hit_params(
  groups,
  tool_capabilities,
  time_from_last_punch
)
  return {}
end

-- ! Utilities

---Returns the location of this directory.
---@return string
function minetest.get_current_modname() end

---@param modname string
function minetest.get_modpath(modname) end

---@return string[]
function minetest.get_modnames() end

---@return string
function minetest.get_worldpath() end

---@return boolean
function minetest.is_singleplayer() end

---- Returning `true` means that Creative Mode is enabled for player `name`.
---- `name` will be `""` for non-players or if the player is unknown.
---- This function should be overridden by Creative Mode-related mods to
---	implement a per-player Creative Mode.
---- By default, this function returns `true` if the setting `creative_mode` is
---	`true` and `false` otherwise.
---@param name string
---@return boolean
function minetest.is_creative_enabled(name) end

---- Handles drops from nodes after digging: Default action is to put them into
--- digger's inventory.
---- Can be overridden to get different functionality (e.g. dropping items on
--- ground).
---@param pos Vector
---@param drops string[] list of itemstrings
---@param digger AnyObjectRef
function minetest.handle_node_drops(pos, drops, digger) end

---@class FeaturesTable
---@field glasslike_framed boolean
---@field nodebox_as_selectionbox boolean
---@field get_all_craft_recipes_works boolean
---@field use_texture_alpha boolean
---@field no_legacy_abms boolean
---@field texture_names_parens boolean
---@field area_store_custom_ids boolean
---@field add_entity_with_staticdata boolean
---@field no_chat_message_prediction boolean
---@field object_use_texture_alpha boolean
---@field object_independent_selectionbox boolean
---@field httpfetch_binary_data boolean
---@field formspec_version_element boolean
---@field area_store_persistent_ids boolean
---@field pathfinder_works boolean
---@field object_step_has_moveresult boolean
---@field direct_velocity_on_players boolean
---@field use_texture_alpha_string_modes boolean
---@field degrotate_240_steps boolean
---@field abm_min_max_y boolean
---@field dynamic_add_media_table boolean
local FeaturesTable = {}

---@type FeaturesTable
minetest.features = {}

---@param arg string | table<string, boolean>
---@return boolean, table<string, boolean> missing
function minetest.has_feature(arg) end

---@class PlayerInfoTable
---@field address string
---@field ip_version integer
---@field connection_uptime number
---@field protocol_version integer
---@field formspec_version integer
---@field lang_code string
---@field min_rtt number
---@field max_rtt number
---@field avg_rtt number
---@field min_jitter number
---@field max_jitter number
---@field avg_jitter number
local PlayerInfoTable = {}

---@param player_name string
---@return PlayerInfoTable
function minetest.get_player_information(player_name) end

---@param path string
---@return boolean success
function minetest.mkdir(path) end

---@param path string
---@param is_dir? boolean
---@return string[]
function minetest.get_dir_list(path, is_dir) end

---@param path string
---@param content string
function minetest.safe_file_write(path, content) end

---@return { project: string, string: string, hash: string }
function minetest.get_version() end

---@param data string
---@param raw? boolean
---@return string
function minetest.sha1(data, raw) end

---@param colorspec ColorSpec
---@return string
function minetest.colorspec_to_colorstring(colorspec) end

---@param colorspec ColorSpec
---@return string
function minetest.colorspec_to_bytes(colorspec) end

---@param width integer
---@param height integer
---@param data ColorSpec[]|string
---@param compression? integer
function minetest.encode_png(width, height, data, compression) end

-- ! Logging

function minetest.debug(...) end

---@param level '"none"'|'"error"'|'"warning"'|'"action"'|'"info"'|'"verbose"'
---@param text string
function minetest.log(level, text) end

-- ! Registration functions

---@param name string
---@param node NodeDefn
function minetest.register_node(name, node) end

---@param name string
---@param item ItemDefn
function minetest.register_craftitem(name, item) end

---@param name string
---@param item ItemDefn
function minetest.register_tool(name, item) end

---@param name string
---@param item ItemDefn
function minetest.override_item(name, item) end

---@param name string
function minetest.unregister_item(name) end

---@param name string
---@param entity EntityDefn
function minetest.register_entity(name, entity) end

---@param name string
---@param abm ABMDefn
function minetest.register_abm(name, abm) end

---@param name string
---@param lbm LBMDefn
function minetest.register_lbm(name, lbm) end

---- This can set quick access names for things.
---- If an item named `alias` already exists,
--- `minetest.register_alias` will do nothing while
--- `minetest.register_alias_force` will unregister it.
---@param alias string
---@param original_name string
function minetest.register_alias(alias, original_name) end

---- This can set quick access names for things.
---- If an item named `alias` already exists,
--- `minetest.register_alias` will do nothing while
--- `minetest.register_alias_force` will unregister it.
---@param alias string
---@param original_name string
function minetest.register_alias_force(alias, original_name) end

---@param ore OreDefn
---@return integer handle
function minetest.register_ore(ore) end

---@param biome BiomeDefn
function minetest.register_biome(biome) end

---@param name string
function minetest.unregister_biome(name) end

---@param decor DecorationDefn
function minetest.register_decoration(decor) end

---@param schem SchematicDefn
function minetest.register_schematic(schem) end

---- Returns the amount of knockback applied on the punched player.
---- Arguments are equivalent to `register_on_punchplayer`, except the following:
---	- `distance`: distance between puncher and punched player
---- This function can be overriden by mods that wish to modify this behaviour.
---- You may want to cache and call the old function to allow multiple mods to
---	change knockback behaviour.
---@param player PlayerObjectRef
---@param hitter AnyObjectRef
---@param time_from_last_punch number
---@param tool_capabilities ToolCapabilities
---@param dir Vector
---@param distance number
---@param damage number
---@return number
function minetest.calculate_knockback(player, hitter, time_from_last_punch,
	tool_capabilities, dir, distance, damage) end

function minetest.clear_registered_biomes() end

function minetest.clear_registered_decorations() end

function minetest.clear_registered_ores() end

function minetest.clear_registered_schematics() end

-- ! Global callback registration functions

---@param cb fun(dtime: number): nil
function minetest.register_globalstep(cb) end

---@param cb fun(): nil
function minetest.register_on_mods_loaded(cb) end

---@param cb fun(): nil
function minetest.register_on_shutdown(cb) end

---@param cb fun(pos: Vector, newnode: any, placer: AnyObjectRef|nil, oldnode: any, itemstack: ItemStack, pointed_thing: PointedThing): nil
function minetest.register_on_placenode(cb) end

---@param cb fun(pos: Vector, oldnode: any, digger: AnyObjectRef|nil): nil
function minetest.register_on_dignode(cb) end

---@param cb fun(pos: Vector, node: any, puncher: AnyObjectRef|nil): nil
function minetest.register_on_punchnode(cb) end

---@param cb fun(minp: Vector, maxp: Vector, blockseed: any): nil
function minetest.register_on_generated(cb) end

---@param cb fun(player: PlayerObjectRef): nil
function minetest.register_on_newplayer(cb) end

---@param cb fun(player: PlayerObjectRef, hitter: PlayerObjectRef, time_from_last_punch: number, tool_capabilities: ToolCapabilities, dir: Vector, damage: number): nil
function minetest.register_on_punchplayer(cb) end

---@param cb fun(player: PlayerObjectRef, clicker: AnyObjectRef): nil
function minetest.register_on_rightclickplayer(cb) end

---@class PlayerHPChangeReason
---@field type '"set_hp"' | '"punch"' | '"fall"' | '"node_damage"' | '"drown"' | '"respawn"'
local PlayerHPChangeReason = {}

---@param cb fun(player: PlayerObjectRef, hp_change: number, reason: PlayerHPChangeReason): nil
---@param modifier boolean when true, the function should return the actual `hp_change`. Note: modifiers only get a temporary `hp_change` that can be modified by later modifiers. Modifiers can return true as a second argument to stop the execution of further functions. Non-modifiers receive the final HP change calculated by the modifiers.
function minetest.register_on_player_hpchange(cb, modifier) end

---@param cb fun(player: PlayerObjectRef, reason: PlayerHPChangeReason): nil
function minetest.register_on_dieplayer(cb) end

---@param cb fun(player: PlayerObjectRef): nil
function minetest.register_on_respawnplayer(cb) end

---@param cb fun(name: string, ip: string): nil
function minetest.register_on_prejoinplayer(cb) end

---@param cb fun(player: PlayerObjectRef, last_login: any): nil
function minetest.register_on_joinplayer(cb) end

---@param cb fun(player: ObjectRef, timed_out: boolean): nil
function minetest.register_on_leaveplayer(cb) end

---@param cb fun(name: string, ip: string, is_success: boolean): nil
function minetest.register_on_authplayer(cb) end

---@param cb fun(name: string, ip: string): nil
function minetest.register_on_auth_fail(cb) end

---@alias CheatType
---| '"moved_too_fast"'
---| '"interacted_too_far"'
---| '"interacted_with_self"'
---| '"interacted_while_dead"'
---| '"finished_unknown_dig"'
---| '"dug_unbreakable"'
---| '"dug_too_fast"'

---@param cb fun(player: PlayerObjectRef, cheat: CheatType): nil
function minetest.register_on_cheat(cb) end

---@param cb fun(name: string, message: string): nil
function minetest.register_on_chat_message(cb) end

---@param cb fun(name: string, command: string, params: string): nil
function minetest.register_on_chatcommand(cb) end

---@param cb fun(player: PlayerObjectRef, formname: string, fields: table): nil
function minetest.register_on_player_receive_fields(cb) end

---@param cb fun(itemstack: ItemStack, player: PlayerObjectRef, old_craft_grid: any, craft_inv: InvRef): ItemStack|nil
function minetest.register_on_craft(cb) end

---@param cb fun(itemstack: ItemStack, player: PlayerObjectRef, old_craft_grid: any, craft_inv: InvRef): ItemStack|nil
function minetest.register_craft_predict(cb) end

---@param cb fun(player: PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: InvRef, inventory_info: table): number|nil
function minetest.register_allow_player_inventory_action(cb) end

---@param cb fun(player: PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: InvRef, inventory_info: table): nil
function minetest.register_on_player_inventory_action(cb) end

---@param cb fun(pos: Vector, name: string): nil
function minetest.register_on_protection_violation(cb) end

---@param cb fun(hp_change: number, replace_with_item: any, itemstack: ItemStack, user: PlayerObjectRef, pointed_thing: PointedThing): nil
function minetest.register_on_item_eat(cb) end

---@param cb fun(name: string, granter: string|nil, priv: string): nil
function minetest.register_on_priv_grant(cb) end

---@param cb fun(name: string, revoker: string|nil, priv: string): nil
function minetest.register_on_priv_revoke(cb) end

---@param cb fun(name: string, ip: string): nil
function minetest.register_can_bypass_userlimit(cb) end

---@param cb fun(channel_name: string, sender: string, message: string): nil
function minetest.register_on_modchannel_message(cb) end

---@param cb fun(pos_list: Vector[], node_list: any[]): nil
function minetest.register_on_liquid_transformed(cb) end

-- ! Authetication

---@param str string
---@param delim? string
---@return table<string, boolean>
function minetest.string_to_privs(str, delim) end

---@param privs table<string, boolean>
---@param delim? string
---@return string
function minetest.privs_to_string(privs, delim) end

---@param name string
---@return table<string, boolean>
function minetest.get_player_privs(name) end

---@param player_or_name string|PlayerObjectRef
---@vararg string|table<string, boolean>
---@return boolean, string|string[] missing
function minetest.check_player_privs(player_or_name, ...) end

---@param name string
---@param entry string
---@param password string
---@return boolean success
function minetest.check_password_entry(name, entry, password) end

---@param name string
---@param raw_password string
---@return string
function minetest.get_password_hash(name, raw_password) end

---@param name string
---@return string
function minetest.get_player_ip(name) end

---@return AuthHandlerDefn
function minetest.get_auth_handler() end

---@param name string
function minetest.notify_authentication_modified(name) end

---@param name string
---@param password_hash string
function minetest.set_player_password(name, password_hash) end

---@param name string
---@param privs table<string, boolean>
function minetest.set_player_privs(name, privs) end

function minetest.auth_reload() end

-- ! Chat

---@param text string
function minetest.chat_send_all(text) end

---@param name string
---@param text string
function minetest.chat_send_player(name, text) end

---@param name string
---@param message string
function minetest.format_chat_message(name, message) end

-- ! Environment access

---@alias NodeSetTable { name: string, param1?: number, param2?: number }

---@param pos Vector
---@param node NodeSetTable
function minetest.set_node(pos, node) end

---@param pos Vector
---@param node NodeSetTable
function minetest.add_node(pos, node) end

---@param positions Vector[]
---@param node NodeSetTable
function minetest.bulk_set_node(positions, node) end

---@param pos Vector
---@param node NodeSetTable
function minetest.swap_node(pos, node) end

---@param pos Vector
function minetest.remove_node(pos) end

---@param pos Vector
---@return NodeSetTable
function minetest.get_node(pos) end

---@param pos Vector
---@return NodeSetTable|nil
function minetest.get_node_or_nil(pos) end

---@param pos Vector
---@param timeofday? number
---@return number|nil
function minetest.get_node_light(pos, timeofday) end

---@param pos Vector
---@param timeofday? number
---@return number|nil
function minetest.get_natural_light(pos, timeofday) end

---@param param1 number
---@return number
function minetest.get_artificial_light(param1) end

---@param pos Vector
---@param node NodeSetTable
function minetest.place_node(pos, node) end

---@param pos Vector
---@return boolean success
function minetest.dig_node(pos) end

---@param pos Vector
function minetest.punch_node(pos) end

---@param pos Vector
---@return boolean, ObjectRef|nil
function minetest.spawn_falling_node(pos) end

---@param pos1 Vector
---@param pos2 Vector
---@return Vector[]
function minetest.find_nodes_with_meta(pos1, pos2) end

---@param pos Vector
---@return NodeMetaRef
function minetest.get_meta(pos) end

---@param pos Vector
---@return NodeTimerRef
function minetest.get_node_timer(pos) end

---@param pos Vector
---@param name string
---@param staticdata? any
---@return ObjectRef|nil
function minetest.add_entity(pos, name, staticdata) end

---@param pos Vector
---@param item ItemStack
function minetest.add_item(pos, item) end

---@param name string
---@return PlayerObjectRef
function minetest.get_player_by_name(name) end

---@param pos Vector
---@param radius number
function minetest.get_objects_inside_radius(pos, radius) end

---@param pos1 Vector
---@param pos2 Vector
---@return ObjectRef[]
function minetest.get_objects_inside_area(pos1, pos2) end

---@param val number
function minetest.set_timeofday(val) end

---@return number
function minetest.get_timeofday() end

---@return integer
function minetest.get_day_count() end

---@param pos Vector
---@param radius number
---@param nodenames string|string[]
---@param search_center? boolean
function minetest.find_node_near(pos, radius, nodenames, search_center) end

---@param pos1 Vector
---@param pos2 Vector
---@param nodenames string|string[]
---@param grouped? boolean
---@return table<string, Vector>|Vector[], nil|table<string, integer>
function minetest.find_nodes_in_area(pos1, pos2, nodenames, grouped) end

---@param pos1 Vector
---@param pos2 Vector
---@param nodenames string|string[]
---@return Vector[]
function minetest.find_nodes_in_area_under_air(pos1, pos2, nodenames) end

---@param params NoiseParams
---@return PerlinNoiseMap
function minetest.get_perlin(params) end

---@param pos1? Vector
---@param pos2? Vector
---@return VoxelManip
function minetest.get_voxel_manip(pos1, pos2) end

---@param flags string[]
---@param deco_ids? integer[]
function minetest.set_gen_notify(flags, deco_ids) end

---@return string[] flags, integer[] ids
function minetest.get_gen_notify() end

---@param decoration_name string
---@return number|nil
function minetest.get_decoration_id(decoration_name) end

---@param objectname string
---@return any
function minetest.get_mapgen_object(objectname) end

---@param pos Vector
---@return number|nil
function minetest.get_heat(pos) end

---@param pos Vector
---@return number|nil
function minetest.get_humidity(pos) end

---@param pos Vector
---@return { biome: integer, hear: integer, humidity: integer }
function minetest.get_biome_data(pos) end

---@param biomename string
---@return integer
function minetest.get_biome_id(biomename) end

---@param name string
---@return any
function minetest.get_mapgen_setting(name) end

---@param name string
---@return NoiseParams
function minetest.get_mapgen_setting_noiseparams(name) end

---@param name string
---@param value any
---@param override_meta? boolean
function minetest.set_mapgen_setting(name, value, override_meta) end

---@param name string
---@param value NoiseParams
---@param override_meta? boolean
function minetest.set_mapgen_setting_noiseparams(name, value, override_meta) end

---@param name string
---@param noiseparams NoiseParams
---@param set_default? boolean
function minetest.set_noiseparams(name, noiseparams, set_default) end

---@param name string
---@return NoiseParams
function minetest.get_noiseparams(name) end

---@param vm VoxelManip
---@param pos1? Vector
---@param pos2? Vector
function minetest.generate_ores(vm, pos1, pos2) end

---@param vm VoxelManip
---@param pos1? Vector
---@param pos2? Vector
function minetest.generate_decorations(vm, pos1, pos2) end

---@param options? { mode?: '"full"'|'"quick"' }
function minetest.clear_objects(options) end

---@param pos1 Vector
---@param pos2? Vector
function minetest.load_area(pos1, pos2) end

---@param pos1 Vector
---@param pos2 Vector
---@param callback? fun(blockpos: Vector, action: any, calls_remaining: integer, param: any)
function minetest.emerge_area(pos1, pos2, callback, param) end

---@param pos1 Vector
---@param pos2 Vector
function minetest.delete_area(pos1, pos2) end

---@param pos1 Vector
---@param pos2 Vector
---@return boolean, Vector
function minetest.line_of_sight(pos1, pos2) end

---@param pos1 Vector
---@param pos2 Vector
---@param objects? boolean
---@param liquids? boolean
---@return Raycast
function minetest.raycast(pos1, pos2, objects, liquids) end

---@param pos1 Vector
---@param pos2 Vector
---@param searchdistance number
---@param max_jump number
---@param max_drop number
---@param algorithm '"A*_noprefetch"'|'"A*"'|'"Dijkstra"'
function minetest.find_path(
  pos1,
  pos2,
  searchdistance,
  max_jump,
  max_drop,
  algorithm
)
end
---@param pos Vector
---@param treedef TreeDef
function minetest.spawn_tree(pos, treedef) end

---@param pos Vector
function minetest.transforming_liquid_add(pos) end

---@param pos Vector
---@return number
function minetest.get_node_max_level(pos) end

---@param pos Vector
---@return number
function minetest.get_node_level(pos) end

---@param pos Vector
---@param level number
function minetest.set_node_level(pos, level) end

---@param pos Vector
---@param level number
function minetest.add_node_level(pos, level) end

---@param pos1 Vector
---@param pos2 Vector
---@return boolean fully_generated
function minetest.fix_light(pos1, pos2) end

---@param pos Vector
function minetest.check_single_for_falling(pos) end

---@param pos Vector
function minetest.check_for_falling(pos) end

---@param x integer
---@param z integer
---@return integer y
function minetest.get_spawn_level(x, z) end

-- ! Mod channels

---@param channel_name string
function minetest.mod_channel_join(channel_name) end

-- ! Inventory

---@param location { type: '"player"', name: string } | { type: '"node"', pos: Vector } | { type: '"detached"', name: string }
function minetest.get_inventory(location) end

---@param name string
---@param callbacks DetachedInvDefn
---@param player_name? string
---@return InvRef
function minetest.create_detached_inventory(name, callbacks, player_name) end

---@param name string
---@return boolean success
function minetest.remove_detached_inventory(name) end

---@param hp_change number
---@param replace_with_item ItemStack
---@param itemstack ItemStack
---@param user any
---@param pointed_thing PointedThing
---@return ItemStack leftover
function minetest.do_item_eat(
  hp_change,
  replace_with_item,
  itemstack,
  user,
  pointed_thing
)
  return {}
end

-- ! Formspec

---@param playername string
---@param formname string
---@param formspec string
function minetest.show_formspec(playername, formname, formspec) end

---@param playername string
---@param formname string
function minetest.close_formspec(playername, formname) end

---@param string string
---@return string
function minetest.formspec_escape(string) end

---@param string string
---@return { type: '"INV"'|'"CHG"'|'"DCL"', row: integer, column: integer }
function minetest.explode_table_event(string) end

---@param string string
---@return { type: '"INV"'|'"CHG"'|'"DCL"', index: integer }
function minetest.explode_textlist_event(string) end

---@param string string
---@return { type: '"INV"'|'"CHG"'|'"DCL"', value: integer }
function minetest.explode_scrollbar_event(string) end

-- ! Item handling

---@param img1 string
---@param img2 string
---@param img3 string
---@return string
function minetest.inventorycube(img1, img2, img3) end

---@param pointed_thing PointedThing
---@param above? boolean
---@return Vector
function minetest.get_pointed_thing_position(pointed_thing, above) end

---@param dir Vector
---@param is6d? boolean
---@return integer
function minetest.dir_to_facedir(dir, is6d) end

---@param facedir integer
---@return Vector
function minetest.facedir_to_dir(facedir) end

---@param dir Vector
---@return integer
function minetest.dir_to_wallmounted(dir) end

---@param wallmounted integer
---@return Vector
function minetest.wallmounted_to_dir(wallmounted) end

---@param dir Vector
---@return number
function minetest.dir_to_yaw(dir) end

---@param yaw number
---@return Vector
function minetest.yaw_to_dir(yaw) end

---@param ptype string
---@return boolean
function minetest.is_colored_paramtype(ptype) end

---@param param2 number
---@param paramtype2 string
---@return number|nil
function minetest.strip_param2_color(param2, paramtype2) end

---@param node string|MapNode
---@param toolname string
---@return string[]
function minetest.get_node_drops(node, toolname) end

---@param input { method: string, width: integer, items: ItemStack[] }
---@return { item: ItemStack, time: number, replacements: ItemStack[] } output, boolean decremented_input
function minetest.get_craft_result(input) end

---@param output string | MapNode
---@return { method: string, width: integer, items: ItemStack[] } input
function minetest.get_craft_recipe(output) end

---@param query string | MapNode
---@return { method: string, width: integer, items: ItemStack[], output: string }[]
function minetest.get_all_craft_recipes(query) end

---@param item ItemStack
---@param palette_index integer
---@return string
function minetest.itemstring_with_palette(item, palette_index) end

---@param item ItemStack
---@param colorstring string
---@return string
function minetest.itemstring_with_color(item, colorstring) end

-- ! Rollback

---@param pos Vector
---@param range number
---@param seconds number
---@param limit number
---@return { actor: string, pos: Vector, time: number, oldnode: MapNode, newnode: MapNode }
function minetest.rollback_get_node_actions(pos, range, seconds, limit) end

---@param actor string
---@param seconds number
---@return boolean, any[] log_messages
function minetest.rollback_revert_actions_by(actor, seconds) end

-- ! Default item callbacks

---@param itemstack ItemStack
---@param placer AnyObjectRef
---@param pointed_thing PointedThing
---@param param2? number
---@param prevent_after_place? boolean
---@return ItemStack, Vector | nil position
function minetest.item_place_node(
  itemstack,
  placer,
  pointed_thing,
  param2,
  prevent_after_place
)
  return {}
end
---@deprecated
---@param itemstack ItemStack
---@param placer AnyObjectRef
---@param pointed_thing PointedThing
---@return ItemStack
function minetest.item_place_object(itemstack, placer, pointed_thing) end

---@param itemstack ItemStack
---@param placer AnyObjectRef
---@param pointed_thing PointedThing
---@param param2 number
---@return ItemStack, Vector position
function minetest.item_place(itemstack, placer, pointed_thing, param2) end

---@param itemstack ItemStack
---@param dropper AnyObjectRef
---@param pos Vector
---@return ItemStack leftover
function minetest.item_drop(itemstack, dropper, pos) end

---@param hp_change number
---@param replace_with_item? string
---@return fun(itemstack: ItemStack, user: any, pointed_thing: PointedThing): any
function minetest.item_eat(hp_change, replace_with_item) end

-- ! Default node callbacks

---@param pos Vector
---@param node MapNode
---@param puncher AnyObjectRef
---@param pointed_thing PointedThing
function minetest.node_punch(pos, node, puncher, pointed_thing) end

---@param pos Vector
---@param node MapNode
---@param digger AnyObjectRef
function minetest.node_dig(pos, node, digger) end

-- ! Sounds

---@param spec SoundSpec
---@param parameters table
---@param ephemeral? boolean
---@return any handle
function minetest.sound_play(spec, parameters, ephemeral) end

---@param handle any
function minetest.sound_stop(handle) end

---@param handle any
---@param step number
---@param gain number
function minetest.sound_fade(handle, step, gain) end

-- ! Timing

---@class JobHandle
local JobHandle = {}

---@param time number
---@param func function
---@vararg any
---@return JobHandle
function minetest.after(time, func, ...) end

function JobHandle:cancel() end

-- ! Server

---@param message? string
---@param reconnect? boolean
---@param delay? number
function minetest.request_shutdown(message, reconnect, delay) end

function minetest.cancel_shutdown_requests() end

---@param name string
---@param joined boolean
---@return string status
function minetest.get_server_status(name, joined) end

---@return number
function minetest.get_server_uptime() end

---@param name string
---@return integer resultcode
function minetest.remove_player(name) end

---@param name string
---@return boolean success
function minetest.remove_player_auth(name) end

---@param options { filepath: string, to_player?: string, ephemeral?: boolean }
---@param callback fun(player_name: string)
---@return boolean success
function minetest.dynamic_add_media(options, callback) end

-- ! Bans

---@return string
function minetest.get_ban_list() end

---@param ip_or_name string
---@return string
function minetest.get_ban_description(ip_or_name) end

---@param name string
---@return boolean success
function minetest.ban_player(name) end

---@param ip_or_name string
function minetest.unban_player_or_ip(ip_or_name) end

---@param name string
---@param reason? string
---@return boolean success
function minetest.kick_player(name, reason) end

-- ! Schematics

---@param p1 Vector
---@param p2 Vector
---@param probability_list { pos: Vector, prob: integer }[]
---@param filename string
---@param slice_prob_list { ypos: integer, prob: integer }[]
function minetest.create_schematic(
  p1,
  p2,
  probability_list,
  filename,
  slice_prob_list
)
end

---@param pos Vector
---@param schematic string | SchematicDefn
---@param rotation '"0"'|'"90"'|'"180"'|'"270"'|'"random"'
---@param replacements table<string, string>
---@param force_placement boolean
---@param flags string
function minetest.place_schematic(
  pos,
  schematic,
  rotation,
  replacements,
  force_placement,
  flags
)
end

---@param vmanip VoxelManip
---@param pos Vector
---@param schematic string | SchematicDefn
---@param rotation '"0"'|'"90"'|'"180"'|'"270"'|'"random"'
---@param replacements table<string, string>
---@param force_placement boolean
---@param flags string
function minetest.place_schematic_on_vmanip(
  vmanip,
  pos,
  schematic,
  rotation,
  replacements,
  force_placement,
  flags
)
end

---@param schematic string | SchematicDefn
---@param format '"mts"'|'"lua"'
---@param options { lua_use_comments?: boolean, lua_num_indent_spaces?: integer }
function minetest.serialize_schematic(schematic, format, options) end

---@param schematic string | SchematicDefn
---@param options { write_yslice_prob?: '"none"'|'"low"'|'"all"' }
function minetest.read_schematic(schematic, options) end

-- ! HTTP requests

---@return HttpApiTable | nil
function minetest.request_http_api() end

-- ! Storage API

---@return StorageRef
function minetest.get_mod_storage() end

-- ! Misc

---@return PlayerObjectRef[]
function minetest.get_connected_players() end

---@param obj any
---@return boolean
function minetest.is_player(obj) end

---@param name string
---@return boolean
function minetest.player_exists(name) end

---@param name string
---@param hud_definition HudDefn
function minetest.hud_replace_builtin(name, hud_definition) end

---@param player_name string
function minetest.send_join_message(player_name) end

---@param player_name string
---@param timed_out boolean
function minetest.send_leave_message(player_name, timed_out) end

---@param pos Vector
---@return number
function minetest.hash_node_position(pos) end

---@param hash number
---@return Vector
function minetest.get_position_from_hash(hash) end

---@param name string
---@param group any
---@return string rating
function minetest.get_item_group(name, group) end

---@param name string
---@return string rating
function minetest.raillike_group(name) end

---@param name string
---@return integer
function minetest.get_content_id(name) end

---@param content_id integer
---@return string
function minetest.get_name_from_content_id(content_id) end

---@param string string
---@param nullvalue? any
---@return any
function minetest.parse_json(string, nullvalue) end

---@param data any
---@param styled? boolean
---@return string
function minetest.write_json(data, styled) end

---@param string string
---@param safe? boolean
---@return any
function minetest.deserialize(string, safe) end

---@param data table
---@return string
function minetest.serialize(data) end

---@param data string
---@param method '"deflate"'
---@vararg any args
---@return string compressed_data
function minetest.compress(data, method, ...) end

---@param compressed_data string
---@param method '"deflate"'
---@vararg any args
---@return string data
function minetest.decompress(compressed_data, method, ...) end

---@param red integer
---@param green integer
---@param blue integer
---@param alpha? integer
---@return string
function minetest.rgba(red, green, blue, alpha) end

---@param string string
---@return string
function minetest.encode_base64(string) end

---@param string string
---@return string | nil
function minetest.decode_base64(string) end

---@param pos Vector
---@param name string
---@return boolean
function minetest.is_protected(pos, name) end

---@param pos Vector
---@param name string
function minetest.record_protection_violation(pos, name) end

---@param pos1 Vector
---@param pos2 Vector
---@param player_name string
---@param interval integer
function minetest.is_area_protected(pos1, pos2, player_name, interval) end

---@param itemstack ItemStack
---@param placer AnyObjectRef
---@param pointed_thing PointedThing
---@param infinitestacks boolean
---@param orient_flags { invert_wall?: boolean, force_wall?: boolean, force_ceiling?: boolean, force_floor?: boolean, force_facedir?: boolean }
---@param prevent_after_place boolean
---@return ItemStack
function minetest.rotate_and_place(
  itemstack,
  placer,
  pointed_thing,
  infinitestacks,
  orient_flags,
  prevent_after_place
)
  return {}
end

---@param itemstack ItemStack
---@param placer AnyObjectRef
---@param pointed_thing PointedThing
function minetest.rotate_node(itemstack, placer, pointed_thing) end

---@param pos Vector
---@param transient? boolean
---@return boolean success
function minetest.forceload_block(pos, transient) end

---@param pos Vector
---@param transient? boolean
function minetest.forceload_free_block(pos, transient) end

---@param pos Vector
---@param condition '"unknown"'|'"emerging"'|'"loaded"'|'"active"'
---@return boolean | nil
function minetest.compare_block_status(pos, condition) end

---@return table | nil
function minetest.request_insecure_environment() end

---@param name string
---@return boolean
function minetest.global_exists(name) end
