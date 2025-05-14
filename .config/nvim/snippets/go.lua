---@diagnostic disable: unused-local
--# selene: allow(unused_variable)
local ls = require 'luasnip'
local s, sn, t, i, f, c, d, r = ls.snippet, ls.snippet_node, ls.text_node, ls.insert_node, ls.function_node, ls.choice_node, ls.dynamic_node, ls.restore_node
local l, rep, p, m, n, dl =
  require('luasnip.extras').lambda,
  require('luasnip.extras').rep,
  require('luasnip.extras').partial,
  require('luasnip.extras').match,
  require('luasnip.extras').nonempty,
  require('luasnip.extras').dynamic_lambda
local fmt, fmta = require('luasnip.extras.fmt').fmt, require('luasnip.extras.fmt').fmta
local types = require 'luasnip.util.types'
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'

-- stylua: ignore
return {
  ---------------------------------------------------------------------------
  -- BASIC BOILERPLATE
  ---------------------------------------------------------------------------
  s("gopkg",      { t{ "package " }, i(1, "main"), t{"", ""} }),
  s("goimports",  { t{ "import (" }, t{ "", '\t"' }, i(1, "fmt"), t{ '"' }, t{ "", ")" } }),
  s("gomain",     { t{ "func main() {", "\t" }, i(0), t{ "", "}" } }),
  s("iferr",      fmt([[if {} != nil {{ return {} }}]], { i(1,"err"), i(2,"err") })),
  s("gofn",       fmt([[func {}({}) {} {{ {} }}]], { i(1,"FuncName"), i(2,"params"), i(3,"ret"), i(0) })),
  s("gostruct",   fmt([[type {} struct {{ {} }}]], { i(1,"Name"), i(2,"Fields") })),
  s("gointerface",fmt([[type {} interface {{ {} }}]], { i(1,"Name"), i(2,"Methods") })),
  s("golog",      { t{'fmt.Println("'}, i(1,"msg"), t{'")'} }),
  s("gotest",     fmt([[func Test{}(t *testing.T) {{ {} }}]], { i(1,"Subject"), i(0) })),

  ---------------------------------------------------------------------------
  -- ADVANCED / SQL (sqlx & pgx)
  ---------------------------------------------------------------------------
  -- sqlx.NamedQuery pattern
  s("sqlxq", fmt([[
    rows, err := {db}.NamedQueryContext({ctx}, `{sql}`, {arg})
    if err != nil {{
        return {}, err
    }}
    defer rows.Close()

    for rows.Next() {{
        var {{}} {}
        if err := rows.StructScan(&{{}}); err != nil {{
            return {}, err
        }}
        {}
    }}
  ]], {
      db  = i(1,"db"),
      ctx = i(2,"ctx"),
      sql = i(3,"SELECT * FROM table WHERE id=:id"),
      arg = i(4,"arg"),
      i(5,"nil"),
      i(6,"item"),
      i(7,"Item"), -- struct type
      rep(6),
      i(8,"nil"),
      i(0),
  })),

  -- pgxpool.QueryRow
  s("pgxq", fmt([[
    var {} {}
    if err := {}.QueryRow({ctx}, `{sql}`, {}).Scan(&{}); err != nil {{
        return {}, err
    }}
  ]], {
      i(1,"out"),
      i(2,"Type"),
      i(3,"pool"),
      ctx = i(4,"ctx"),
      sql = i(5,"SELECT col FROM table WHERE id=$1"),
      i(6,"id"),
      rep(1),
      i(7,"nil"),
  })),

  ---------------------------------------------------------------------------
  -- HTTP / net-http
  ---------------------------------------------------------------------------
  -- Register handler with default mux
  s("httpwire", fmt([[http.HandleFunc("{}", {})]], { i(1,"/path"), i(2,"handlerName") })),

  -- Logging middleware for net-http
  s("lmw", fmt([[
    func LoggingMiddleware(next http.Handler) http.Handler {{
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {{
            start := time.Now()
            next.ServeHTTP(w, r)
            log.Printf("%s %s %s", r.Method, r.URL.Path, time.Since(start))
        }})
    }}
  ]], {})),

  -- Read/write/close middleware (example)
  s("rwmw", fmt([[
    func RWMiddleware(next http.Handler) http.Handler {{
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {{
            w.Header().Set("Content-Type", "application/json")
            next.ServeHTTP(w, r)
        }})
    }}
  ]], {})),

  ---------------------------------------------------------------------------
  -- TEST HELPERS
  ---------------------------------------------------------------------------
  -- Quick setup / teardown helper
  s("testsetup", fmt([[
    func setup(t *testing.T) func() {{
        t.Helper()
        {} // init resources

        return func() {{
            {} // cleanup
        }}
    }}
  ]], {
      i(1,"// TODO: setup"),
      i(2,"// TODO: teardown"),
  })),

  -- Table-driven test (expanded)
  s("gotesttable", fmt([[
    func Test{}(t *testing.T) {{
        t.Parallel()
        tests := []struct {{
            name string
            input {}
            want  {}
        }}{{
            {{ name: "happy-path", input: {}, want: {} }},
        }}

        for _, tt := range tests {{
            tt := tt
            t.Run(tt.name, func(t *testing.T) {{
                t.Parallel()
                got := {}(tt.input)
                if !reflect.DeepEqual(got, tt.want) {{
                    t.Errorf("got %#v, want %#v", got, tt.want)
                }}
            }})
        }}
    }}
  ]], {
      i(1,"Func"),
      i(2,"In"),
      i(3,"Out"),
      i(4,"zeroIn"),
      i(5,"zeroOut"),
      rep(1),
  })),

  ---------------------------------------------------------------------------
  -- GIN
  ---------------------------------------------------------------------------
  s("ginroute", fmt([[r.{}("{}{}", func(c *gin.Context) {{ {} }})]], {
    c(1, { t"GET", t"POST", t"PUT", t"DELETE" }),
    t"/",
    i(2,"path"),
    i(0),
  })),

  s("ginmw", fmt([[
    func {}() gin.HandlerFunc {{
        return func(c *gin.Context) {{
            {}
            c.Next()
        }}
    }}
  ]], { i(1,"MyMiddleware"), i(0) })),

  ---------------------------------------------------------------------------
  -- FIBER
  ---------------------------------------------------------------------------
  s("fiberroute", fmt([[app.{}("{}{}", func(c *fiber.Ctx) error {{ {} return c.SendStatus(fiber.StatusOK) }})]], {
    c(1,{ t"Get", t"Post", t"Put", t"Delete" }),
    t"/",
    i(2,"path"),
    i(0),
  })),

  ---------------------------------------------------------------------------
  -- ECHO
  ---------------------------------------------------------------------------
  s("echoroute", fmt([[e.{}("{}{}", func(c echo.Context) error {{ {} return c.String(http.StatusOK, "ok") }})]], {
    c(1,{ t"GET", t"POST", t"PUT", t"DELETE" }),
    t"/",
    i(2,"path"),
    i(0),
  })),
}
