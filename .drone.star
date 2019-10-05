def main(ctx):
  return [
    pipeline("linux", "amd64", "1.0"),
    pipeline("linux", "amd64", "1.2"),
  ]

def pipeline(os, arch, julia):
  return {
    "kind": "pipeline",
    "type": "docker",
    "name": "Julia %s - %s - %s" % (julia, os, arch),
    "steps": [{
      "name": "Tests",
      "image": "julia:%s" % julia,
      "commands": [
        "julia --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.build(); Pkg.test();'",
      ]
    }]
  }
