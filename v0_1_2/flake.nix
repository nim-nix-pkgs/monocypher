{
  description = ''Monocypher'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-monocypher-v0_1_2.flake = false;
  inputs.src-monocypher-v0_1_2.owner = "markspanbroek";
  inputs.src-monocypher-v0_1_2.ref   = "refs/tags/v0.1.2";
  inputs.src-monocypher-v0_1_2.repo  = "monocypher.nim";
  inputs.src-monocypher-v0_1_2.type  = "github";
  
  inputs."nimterop".dir   = "nimpkgs/n/nimterop";
  inputs."nimterop".owner = "riinr";
  inputs."nimterop".ref   = "flake-pinning";
  inputs."nimterop".repo  = "flake-nimble";
  inputs."nimterop".type  = "github";
  inputs."nimterop".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimterop".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."sysrandom".dir   = "nimpkgs/s/sysrandom";
  inputs."sysrandom".owner = "riinr";
  inputs."sysrandom".ref   = "flake-pinning";
  inputs."sysrandom".repo  = "flake-nimble";
  inputs."sysrandom".type  = "github";
  inputs."sysrandom".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sysrandom".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-monocypher-v0_1_2"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-monocypher-v0_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}