# TwinklyHaHa
Twinkly is the
digital twin of blinky (ie in cloud instead of on Raspberry Pi, LiveView graphics instead of LEDs).

Blinky looks like:
[![blinky](./docs/blinky.jpeg)](https://www.youtube.com/watch?v=RcnRFfFtKQY)

Twinkly looks like:
![twinklygif](https://user-images.githubusercontent.com/584211/88267055-ed08ca80-ccd8-11ea-89ab-6760e772eb10.gif)

HaHa is Http Api Helloworld openc2 Actuator.

## Install & Run
just phoenix boilerplate for now. needs work.

First ensure you have the following set up in your computer
- elixir 1.10.4
- nodejs > 12 LTS
- Postgresql > 11

You can use [the phoenix installation guide](https://hexdocs.pm/phoenix/installation.html#content) to ensure you
have everything set up as expected


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser -
which gives you the Phoenix home page.

Visit [`localhost:4000/twinkly`](http://localhost:4000/twinkly) to get web blinking lights, under web button control.

Watch this page while sending commands via OpenC2 API at [`localhost:4000/openc2`](http://localhost:4000/openc2) and watch the commands change the lights. 

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
