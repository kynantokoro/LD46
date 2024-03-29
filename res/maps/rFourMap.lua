return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 64,
  height = 24,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 5,
  nextobjectid = 10,
  properties = {},
  tilesets = {
    {
      name = "Tileset1",
      firstgid = 1,
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "Tileset.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 1024,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 3,
      name = "Background",
      x = 0,
      y = 0,
      width = 64,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 6, 6, 6, 6, 6, 105, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 170, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 106, 4, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 42, 10, 170, 6, 6, 6, 6, 6, 6, 6, 42, 42, 6, 6, 6, 6, 6, 4, 170, 3, 170, 106, 6, 6, 136, 36, 104, 6, 6, 6, 6,
        6, 6, 6, 10, 100, 100, 10, 106, 42, 6, 6, 6, 6, 6, 169, 6, 6, 6, 6, 6, 42, 6, 6, 6, 6, 6, 6, 169, 6, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6, 6, 6, 6, 6, 10, 170, 10, 6, 6, 6, 6, 106, 6, 100, 6, 6, 6, 6, 6, 169, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 106, 136, 170, 6, 105, 6, 6, 6, 6, 6, 169, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 168, 4, 138, 4, 6, 6, 6, 6, 137, 6, 6, 6, 6, 6, 6, 6, 35, 106, 170, 138, 3, 6, 6, 6, 6, 6, 138, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 104, 10, 6, 6, 6, 6, 6, 6, 3, 106, 136, 6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 138, 100, 168, 36, 6, 6, 6, 6, 168, 6, 6, 6, 6, 6, 6, 6, 136, 35, 35, 136, 136, 6, 6, 6, 6, 6, 132, 6, 6, 6, 6, 6, 100, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 138, 6, 6, 6, 6, 6, 6, 132, 3, 36, 104, 4, 6, 6, 6, 6, 6, 6, 6, 6, 6, 136, 100, 169, 6, 6, 6, 6, 6, 6, 6, 10, 6, 6, 6, 6, 6, 6, 36, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 10, 35, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 105, 105, 6, 6, 6, 6, 6, 6, 136, 36, 132, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 137, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 6, 6, 6, 6, 6, 136, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 169, 168, 138, 138, 170, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 100, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6, 10, 10, 137, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 105, 170, 138, 3, 132, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 136, 6, 6, 6, 6, 6, 6, 138, 6, 6, 6, 6, 6,
        6, 169, 35, 36, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 104, 10, 3, 100, 168, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 136, 105, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 36, 6, 6, 6, 6, 6, 105, 6, 6, 6, 6, 6,
        6, 6, 4, 6, 6, 6, 6, 6, 168, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 100, 10, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 136, 105, 36, 6, 6, 104, 36, 10, 105, 136, 106, 6, 6, 6,
        6, 6, 170, 6, 6, 6, 6, 136, 137, 132, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 168, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 100, 6, 6, 6, 6, 6, 6, 6, 3, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 36, 132, 42, 169, 3, 6, 6, 6, 6, 168, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 35, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 35, 6, 6, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 35, 104, 137, 6, 6, 6, 6, 6, 42, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 136, 35, 35, 132, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 169, 36, 168, 6, 6, 6, 6, 6, 105, 6, 6, 6, 6, 6, 6, 6, 169, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 105, 6, 6, 6, 6, 10, 170, 105, 42, 6, 6, 6, 6, 6, 6, 6, 6, 6, 170, 168, 100, 104, 132, 170, 100, 168, 6, 6, 6, 6, 6, 6, 169, 104, 6, 35, 42, 42, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 137, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 6, 6, 6, 6, 6, 136, 6, 6, 6, 6, 6, 6, 106, 169, 170, 42, 6, 6, 6, 6, 6, 6, 6, 10, 42, 6, 168, 42, 42, 35, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 36, 6, 6, 6, 6, 6, 6, 6, 10, 138, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 136, 106, 6, 6, 6, 6, 6, 6, 6, 6, 42, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 42, 168, 169, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 136, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 138, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 169, 42, 100, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
        6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
      }
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Collision",
      x = 0,
      y = 0,
      width = 64,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "Player",
          shape = "polygon",
          x = 40,
          y = 152,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 16, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {
            ["animation_path"] = "res/sprite/Player.json",
            ["initial_tag"] = "VIP"
          }
        },
        {
          id = 2,
          name = "",
          type = "Door",
          shape = "polyline",
          x = 32,
          y = 152,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 16, y = 16 },
            { x = 16, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {
            ["initial_tag"] = "CLOSE"
          }
        },
        {
          id = 4,
          name = "",
          type = "Door",
          shape = "polyline",
          x = 480,
          y = 168,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 16, y = 16 },
            { x = 16, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {
            ["initial_tag"] = "OPEN"
          }
        },
        {
          id = 5,
          name = "",
          type = "Key",
          shape = "polygon",
          x = 376,
          y = 56,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 8 },
            { x = 8, y = 8 },
            { x = 8, y = 0 }
          },
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "Enemy",
          shape = "polygon",
          x = 120,
          y = 168,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 8, y = 16 },
            { x = 8, y = 0 }
          },
          properties = {
            ["animation_path"] = "res/sprite/Enemy.json",
            ["etype"] = "Red",
            ["initial_tag"] = "RED"
          }
        },
        {
          id = 7,
          name = "",
          type = "Enemy",
          shape = "polygon",
          x = 336,
          y = 88,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 8, y = 16 },
            { x = 8, y = 0 }
          },
          properties = {
            ["animation_path"] = "res/sprite/Enemy.json",
            ["etype"] = "Green",
            ["initial_tag"] = "GREEN"
          }
        },
        {
          id = 8,
          name = "",
          type = "Enemy",
          shape = "polygon",
          x = 192,
          y = 168,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 8, y = 16 },
            { x = 8, y = 0 }
          },
          properties = {
            ["animation_path"] = "res/sprite/Enemy.json",
            ["etype"] = "Red",
            ["initial_tag"] = "RED"
          }
        },
        {
          id = 9,
          name = "",
          type = "Enemy",
          shape = "polygon",
          x = 344,
          y = 136,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 8, y = 16 },
            { x = 8, y = 0 }
          },
          properties = {
            ["animation_path"] = "res/sprite/Enemy.json",
            ["etype"] = "Green",
            ["initial_tag"] = "GREEN"
          }
        }
      }
    },
    {
      type = "tilelayer",
      id = 4,
      name = "Foreground",
      x = 0,
      y = 0,
      width = 64,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 0, 0, 15, 16, 0, 0, 15, 16, 0, 0, 0, 47, 48, 48, 0, 0, 13, 14, 0, 117, 117, 117, 0, 13, 14, 0, 0, 79, 117, 148, 0, 0, 13, 14, 0, 80, 116, 117, 0, 18, 18, 19, 18, 19,
        0, 15, 16, 0, 0, 45, 46, 0, 0, 0, 0, 0, 0, 18, 19, 20, 21, 0, 45, 46, 0, 0, 47, 48, 0, 0, 47, 48, 0, 45, 80, 79, 80, 80, 0, 0, 45, 46, 0, 0, 0, 0, 0, 45, 46, 0, 0, 45, 0, 45, 147, 0, 45, 46, 0, 0, 117, 116, 0, 50, 50, 51, 50, 51,
        0, 47, 48, 0, 0, 0, 0, 18, 18, 19, 20, 21, 0, 50, 51, 52, 53, 0, 15, 16, 13, 14, 79, 80, 0, 0, 79, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 82, 83, 82, 83,
        0, 79, 80, 19, 20, 21, 0, 50, 50, 18, 19, 20, 21, 82, 83, 84, 85, 0, 47, 48, 45, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 114, 115, 114, 115,
        0, 0, 50, 51, 52, 53, 19, 82, 82, 50, 51, 52, 53, 114, 115, 116, 117, 0, 79, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 148, 48, 146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 146, 146, 147, 146, 147,
        0, 0, 82, 83, 84, 85, 51, 114, 114, 82, 83, 18, 19, 20, 21, 148, 149, 0, 0, 0, 18, 19, 20, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 146, 0, 0, 0, 0, 0, 85, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 114, 115, 18, 18, 19, 146, 146, 114, 115, 18, 19, 20, 21, 0, 0, 19, 20, 0, 50, 51, 52, 53, 0, 0, 0, 0, 0, 0, 0, 0, 148, 80, 47, 117, 85, 80, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 18, 146, 147, 50, 50, 51, 52, 53, 146, 147, 50, 51, 52, 53, 18, 19, 51, 52, 0, 82, 83, 84, 85, 0, 0, 0, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        15, 16, 51, 52, 82, 82, 83, 84, 85, 0, 0, 82, 83, 84, 85, 50, 51, 83, 84, 0, 114, 115, 116, 117, 0, 0, 0, 0, 0, 146, 148, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        47, 48, 83, 84, 114, 114, 115, 116, 117, 0, 0, 13, 14, 116, 117, 82, 83, 115, 116, 0, 146, 147, 148, 149, 0, 0, 0, 0, 80, 80, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 85, 0, 0, 0, 0, 0, 0, 79, 80, 146, 0, 0, 0, 0, 0, 0, 148,
        79, 80, 115, 116, 146, 146, 147, 148, 149, 13, 14, 45, 46, 148, 149, 114, 115, 147, 148, 0, 0, 0, 0, 0, 0, 0, 0, 148, 14, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114,
        0, 146, 147, 18, 19, 20, 21, 0, 0, 45, 46, 114, 79, 0, 0, 146, 147, 0, 149, 0, 0, 0, 0, 0, 0, 0, 45, 146, 117, 0, 0, 0, 0, 0, 0, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 146,
        0, 79, 115, 50, 51, 52, 53, 148, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 14, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47,
        79, 79, 45, 82, 83, 84, 85, 79, 116, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 116, 0, 0, 0, 0, 0, 0, 0, 48, 0, 45, 46, 148, 117, 14, 148, 115, 14, 115, 79, 80, 114, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 85, 48, 146, 45,
        47, 48, 114, 114, 115, 116, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115, 48, 0, 0, 0, 0, 0, 0, 0, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115,
        79, 0, 0, 146, 147, 148, 149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 45, 146, 45, 80, 148, 114, 0, 0, 0, 0, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115,
        115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 147, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 48, 116, 0, 0, 0, 0, 0, 0, 0, 14,
        114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 79, 79, 79, 116, 148, 14, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 146,
        79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116,
        114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 0, 0, 0, 0, 0, 0, 117, 45, 80, 116, 0, 116, 80, 148, 117, 117, 0, 0, 79, 79, 148, 116, 80, 0, 0, 0, 0, 0, 0, 85, 146, 114, 80, 48, 146,
        146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        146, 0, 0, 14, 45, 80, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 45, 80, 147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        147, 116, 14, 146, 0, 0, 14, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 114, 117, 117, 114, 115, 117, 148, 114, 14, 47, 47, 0, 116, 114, 45, 79, 117, 80, 0, 0, 0, 148, 147, 14, 80, 117, 114, 116, 117, 116, 114, 148, 80, 45, 79, 148, 45, 14, 45, 117, 80, 79, 14, 116, 80, 114, 116, 117, 116, 148, 79, 79, 117, 147, 117, 0
      }
    }
  }
}
