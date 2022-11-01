with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "gaia-social";
    buildInputs = [
        git
        
        (pkgs.php.buildEnv {
            extensions = ({ enabled, all }: enabled ++ (with all; [
              redis
            ]));
            extraConfig = ''
            '';
          })

        php81
        php81Packages.composer

        nodejs-18_x
        nodePackages.npm

        docker
        docker-compose

	# Even though we run this in docker
	# the installer wants access to a binary
	# so this might be a different version
	# than the redis version in docker.
        redis

        tmux

        ffmpeg_5
        jpegoptim
        optipng
        pngquant
        gifsicle

        jq
    ];
}
