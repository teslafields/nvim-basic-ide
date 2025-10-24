return {
  settings = {
    rust_analyzer = {
      buildScripts = { rebuildOnSave = false },
      cachePriming = { enable = false },
      numThreads = 4,
      cargo = { allTargets = false },
    },
  },
}
