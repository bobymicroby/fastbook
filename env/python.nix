with (import ./inputs.nix);
mach-nix.mkPython {
  requirements = builtins.readFile ./requirements.txt;
  providers.torch = "nixpkgs";
  overridesPost = [(curr: prev: {
    torch = prev.torch.override {
      cudaSupport = true;
    };
  })];
  _.jupyter-core.postInstall = ''
    rm $out/lib/python3.7/site-packages/__pycache__/jupyter.cpython-37.pyc
    rm $out/lib/python3.7/site-packages/jupyter.py
  '';
}
