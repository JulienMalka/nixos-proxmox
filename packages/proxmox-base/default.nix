{ lib, fetchgit, rustPlatform, pkg-config, openssl, gcc, rustup, luajitPackages }:

rustPlatform.buildRustPackage {
  pname = "proxmox-base";
  version = "0.1.0";

  src = fetchgit {
    url = "https://git.proxmox.com/git/proxmox.git";
    sha256 = "sha256-jN1nR0EBtaVYvLSMrjfdj+FFD2KeCN4KDwvzpfI+mHI=";
  };

  cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtzts=";

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  nativeBuildInputs = [ pkg-config openssl rustPlatform.bindgenHook ];

  buildInputs = [ openssl ];


  patchPhase = ''
    cp ${./Cargo.lock} Cargo.lock 
    rm  .cargo/config
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out
    ls -a
  '';

  doCheck = false;

  meta = with lib; {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = licenses.unlicense;
    maintainers = [ maintainers.julienmalka ];
  };
}
