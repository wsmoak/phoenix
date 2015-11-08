defmodule Phoenix.Mixfile do
  use Mix.Project

  @version "1.0.4-dev"

  def project do
    [app: :phoenix,
     version: @version,
     elixir: "~> 1.0.2 or ~> 1.1-beta",
     deps: deps,
     package: package,

     # Because we define protocols on the fly to test
     # Phoenix.Param, we need to disable consolidation
     # for the test environment for Elixir v1.2 onward.
     consolidate_protocols: Mix.env != :test,

     name: "Phoenix",
     docs: [source_ref: "v#{@version}", main: "Phoenix", logo: "logo.png", extra_section: "GUIDES",
       extras: [
            {"deps/phoenix_guides/A_up_and_running.md", "Custom Menu Title"},
            "deps/phoenix_guides/B_adding_pages.md",
            "deps/phoenix_guides/C_routing.md",
            "deps/phoenix_guides/D_controllers.md",
         ]
       ],
     source_url: "https://github.com/phoenixframework/phoenix",
     homepage_url: "http://www.phoenixframework.org",
     description: """
     Productive. Reliable. Fast. A productive web framework that
     does not compromise speed and maintainability.
     """]
  end

  defp add_path(files) do
    Enum.map(files, &("deps/phoenix_guides/" <> &1))
  end

  def application do
    [mod: {Phoenix, []},
     applications: [:plug, :poison, :logger, :eex],
     env: [stacktrace_depth: nil,
           template_engines: [],
           format_encoders: [],
           generators: [],
           filter_parameters: ["password"],
           serve_endpoints: false,
           gzippable_exts: ~w(.js .css .txt .text .html .json)]]
  end

  defp deps do
    [{:cowboy, "~> 1.0", optional: true},
     {:plug, "~> 1.0"},
     {:poison, "~> 1.3"},

     # Docs dependencies
     {:earmark, "~> 0.1", only: :docs},
#     {:ex_doc, github: "wsmoak/ex_doc", branch: "h1-as-menu-item", only: :docs},
     {:ex_doc, path: "../ex_doc-wsmoak", only: :docs},
#     {:ex_doc, github: "elixir-lang/ex_doc", only: :docs},
     {:inch_ex, "~> 0.2", only: :docs},
     {:phoenix_guides, github: "wsmoak/phoenix_guides", branch: "ex_doc_no_rename", only: :docs, app: false, compile: false},

     # Test dependencies
     {:phoenix_html, "~> 1.2", only: :test},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client.git", only: :test}]
  end

  defp package do
    [contributors: ["Chris McCord", "José Valim", "Lance Halvorsen",
                    "Jason Stiebs", "Eric Meadows-Jönsson", "Sonny Scroggin"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/phoenixframework/phoenix"},
     files: ~w(lib priv test/shared web) ++
            ~w(brunch-config.js CHANGELOG.md LICENSE.md mix.exs package.json README.md)]
  end
end
