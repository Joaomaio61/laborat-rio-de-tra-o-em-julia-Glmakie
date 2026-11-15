
using GLMakie

f = Figure(size = (750, 500))

ax = Axis(
    f[1, 1],
    xlabel = "Deformação (ϵ)",
    ylabel = "Tensão (τ)",
    title = "Tensão × Deformação"
)

rowsize!(f.layout, 1, Relative(0.85))
colsize!(f.layout, 1, Relative(0.85))

tbx = Textbox(f[2, 1], placeholder = "Deformação")
tby = Textbox(f[3, 1], placeholder = "Tensão")

btn = Button(f[2:3, 2], label = "Confirmar")

status = Label(f[4, 1:2], "Aguardando dados...")

xs = Observable(Float64[])
ys = Observable(Float64[])

lines!(ax, xs, ys, color = :green, linewidth = 2)
scatter!(ax, xs, ys, color = :crimson, markersize = 10)

on(btn.clicks) do _

    try
        deformacao = parse(Float64, tbx.displayed_string[])
        tensao = parse(Float64, tby.displayed_string[])

         xs[] = [xs[]; deformacao]
         ys[] = [ys[]; tensao]

        tbx.displayed_string[] = ""
        tby.displayed_string[] = ""

        status.text = "Ponto adicionado: ($deformacao, $tensao)"

    catch
        status.text = "Erro: digite valores numéricos válidos!"
    end

end

display(f)


