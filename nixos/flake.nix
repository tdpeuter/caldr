{
  description = "A lightweight CLI / TUI calendar that supports CalDAV";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      version = builtins.substring 0 8 self.lastModifiedDate;
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in {
          default = pkgs.buildGoModule {
            pname = "caldr";
            inherit version;
            src = pkgs.fetchFromGitHub {
              owner = "tdpeuter";
              repo = "caldr";
              rev = "9848ec5";
              sha256 = "sha256-Mi+koFVMq1unjmR/NsfCU+0GEDs0NC8fR/yEP/yxHe4=";
            };
            vendorSha256 = "sha256-jPz3Xi2RDFVKcUmFJmmVniHID2peZBBy+NjEE6pW5kw=";
          };
        });
      };
    }
