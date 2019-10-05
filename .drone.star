def main(ctx):
  pipelines = []
  for os in ["freebsd", "dragonfly",]:
    for arch in ["amd64", "arm"]:
      for julia in ["1.0", "1.2"]:
        pipelines.append(pipeline(os, arch, julia))
  return pipelines

def pipeline(os, arch, julia):
  return {
    "kind": "pipeline",
    "type": "docker",
    "name": "Julia %s - %s - %s" % (julia, os, arch),
    "steps": [{
      "name": "Tests",
      "image": "julia:%s" % julia,
      "commands": [
        "julia -e 'using InteractiveUtils; versioninfo()'",
        "julia --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.build(); Pkg.test();'",
      ]
    }]
  }
