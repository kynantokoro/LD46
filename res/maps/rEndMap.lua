return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 24,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 4,
  nextobjectid = 6,
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
      id = 1,
      name = "Collision",
      x = 0,
      y = 0,
      width = 24,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
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
          x = 32,
          y = 168,
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
            ["initial_tag"] = "IDLE"
          }
        },
        {
          id = 2,
          name = "",
          type = "Door",
          shape = "polyline",
          x = 24,
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
            ["initial_tag"] = "CLOSE"
          }
        },
        {
          id = 3,
          name = "",
          type = "Door",
          shape = "polyline",
          x = 160,
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
        }
      }
    }
  }
}
