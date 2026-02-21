return {
  -- cmd = "rust-analyzer-limited",
  settings = {
    rust_analyzer = {
      buildScripts = { rebuildOnSave = false, enable = true },
      procMacro = { enable = false },
      cachePriming = { enable = false },
      numThreads = 4,
      cargo = { allTargets = false, allFeatures = false },
      checkOnSave = { enable = false },
      files = {
        excludeDirs = { "target", "vendor" },
      },
    },
  },
}
