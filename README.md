# Fakebook

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Tips

### Create a new database

```bash
  mix ecto.create
```

If you have trouble connecting to the database, check your db settings in `config/dev.exs`.


### Generating a model

Model generator takes 3 or more arguments, the first being the model name, the second the
database table name, then any schema declarations.

```bash
  mix phoenix.gen.model Tune tunes name:string
```

### Run migrations

```bash
  mix ecto.migrate
```

### Adding a new record via the REPL

```bash
  iex -S mix
```
```elixir
  tune = %Fakebook.Tune {name: "Morven's March"}
  Fakebook.Repo.insert!(tune)
```
