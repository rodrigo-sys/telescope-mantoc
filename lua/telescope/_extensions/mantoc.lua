return require("telescope").register_extension {
  exports = {
    mantoc = require("mantoc")
  },
}
