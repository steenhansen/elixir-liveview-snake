

1 INSTALL WSL  https://hexdocs.pm/phoenix/installation.html

    > wsl --install
    > wsl ====================================================================================================>  r

    $ sudo apt-get install erlang
    $ sudo apt-get install elixir
    $ sudo apt-get install inotify-tools
    $ mix local.hex
    $ mix archive.install hex phx_new

2 INSTALL FLY.IO  https://fly.io/docs/hands-on/install-flyctl/

    $ curl -L https://fly.io/install.sh | sh
    $ export FLYCTL_INSTALL="/home/rhino/.fly"
    $ export PATH="$FLYCTL_INSTALL/bin:$PATH"

    https://fly.io/app/sign-in    https://hexdocs.pm/phoenix/fly.html


3 MAKE APP  https://hexdocs.pm/phoenix/up_and_running.html

    $ mix phx.new multi_game --no-ecto --live
    $ cd multi_game

$ mix phx.gen.presence

    $ mix phx.server =========================================================================================>  http://localhost:4000/

http://localhost:4000/guess


    $ iex -S mix phx.server

    $ mix compile.unused    # gives line numbers on unused functions

3 COMPILE APP https://hexdocs.pm/phoenix/deployment.html

    $ mix phx.gen.secret  ==> bgzgR0KxitzEg6E8bNRB/Kxswoduax1l4EA5P8oQwrKWDpMaT/ixx0of+/000+JS
    $ mix deps.get --only prod
    $ MIX_ENV=prod mix compile
    $ MIX_ENV=prod mix assets.deploy

    $ export SECRET_KEY_BASE=bgzgR0KxitzEg6E8bNRB/Kxswoduax1l4EA5P8oQwrKWDpMaT/ixx0of+/000+JS
    $ PORT=4001 MIX_ENV=prod mix phx.server  =================================================================>  http://localhost:4001/

4 DEPLOY TO FLY.IO  https://hexdocs.pm/phoenix/fly.html   

    $ flyctl auth login ======================================================================================>  sinkCassette1492
      Copy the url https://fly.io/app/auth/cli/ed3837f44a7f819f26c70a1e941d91a3 into browser
    
    $ fly launch
    $ fly secrets set SECRET_KEY_BASE=1JWmvVZsazeU93mhnPtPSxNVev6BWib1ok1Wtk8rF35T7+ZOH4Sr8OOGXG2P7urF
    $ fly deploy    https://long-dawn-9814.fly.dev/


PS C:\a\multi_game> flyctl auth login 
PS C:\a\multi_game> fly launch
PS C:\a\multi_game> fly deploy