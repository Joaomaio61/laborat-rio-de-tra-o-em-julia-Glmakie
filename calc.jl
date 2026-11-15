using Printf
using GLMakie

println("Bem vindo Ao Laboratório Virtual de Ensaio de Tração")

while true

println("Boas Vindas oque deseja fazer?
-o que sao? tração e deformação?(1)
-calculo de tração(2)
-Grafico de tensao x deformação(3)
-propriedades dos materiais.(4)
-relatorio final(5)")


resposta = parse(Int64,readline())

if resposta == 0
    println("até logo!")

elseif resposta == 1
    print("A tração é uma força axial aplicada perpendicularmente à seção transversal de um corpo, atuando para fora dele, o que tende a alongar a peça e reduzir sua área transversal.  A deformação é a medida da mudança relativa na geometria do material (variação do comprimento) resultante dessa tensão aplicada, sendo calculada pela razão entre o alongamento e o comprimento original (
ε=ΔL/L 
0
​
 ). 

Existem dois tipos principais de deformação durante o ensaio de tração: a elástica, que é reversível e desaparece quando a força é removida, e a plástica, que é permanente e ocorre após o material ultrapassar seu limite de escoamento.  Esses conceitos são fundamentais para determinar propriedades mecânicas como o módulo de elasticidade, o limite de resistência e a ductilidade dos materiais. ")


elseif resposta == 2

    println("apos o teste qual valor final que ficou o corpo de teste")
    l = parse(Float64,readline())


    println("qual valor inicial do seu corpo de teste?")
    l0 = parse(Float64,readline())

    println("qual a Força ou carga aplicada(N)")
    f = parse(Float64,readline())

    println("qual a area da seção transversal(π * r²)")
    a0 = parse(Float64,readline())

    global deltal = (l - l0)

    global e = (deltal/l0)

    global sigma = (f/a0)


    println("\n--- RESULTADOS ---")
    @printf("A tensão aplicada (σ) é: %.3f Pa (ou N/m²)\n", sigma)
    @printf("A deformação (ϵ) foi de: %.3f (adimensional)\n", e)

    


    


elseif resposta == 3
    println("\nAbrindo interface gráfica... (Insira os pontos, feche a janela quando terminar para ver os resultados)")
    include("graficotracao.jl")
    
    
elseif resposta == 4
    tem_dados = @isdefined(e)
    if !tem_dados
        println("\nNENHUM DADO ANTERIOR ENCONTRADO ")
        println("Insira os dados do corpo de prova para calcular as propriedades:")

        println("Após o teste, qual valor final ficou o corpo de teste (L)?")
        l = parse(Float64, readline())

        println("Qual valor inicial do seu corpo de teste (L0)?")
        l0 = parse(Float64, readline())

        global e =(l-l0)/l0
    else
        @printf("Usando deformação anterior: ε = %.5f\n", e)
    end

    

        #propriedade do material ou manual
    println("\nEscolha o material:")
    println(" (1) Aço carbono ")
    println(" (2) Alumínio 6061-T6 ")
    println(" (3) Cobre recozido")
    println(" (4) Informar manualmente"
    )

    opcao = parse(Int64,readline())

    if opcao== 1
        global E = 200e9
        global sigma_y = 250e6
    elseif opcao == 2
        global E = 69e9
        global sigma_y = 275e6
    elseif opcao == 3
        global E = 110e9
        global sigma_y = 70e6
    elseif opcao == 4
        println("Módulo de elasticidade E (Pa):")
        global E = parse(Float64,readline())
        println("limite de escoamento(fase de transção entre a fase plastica e fase elastica)")
        global sigma_y = parse(Float64,readline())
    else 
        @warn "Opção invalidaaaaaaaaaaa"
    end

    if opcao >=1 && opcao <=4
        global e_limite = sigma_y/E
        global e_elastica = min(e, e_limite) #o truqu(tá pegando o menor valor(def_elastica))
        global e_plastica = max(e - e_limite, 0.0) #ao contrario so pra nao ser negativo

        @printf("\nDeformação total (ε): %.6f\n", e)
        @printf("Limite elástico do material (σy/E): %.6f\n", e_limite)

        if e <= e_limite
            println("Comportamento: ELÁSTICO (reversível, o material volta ao formato original).")
        else
            println("Comportamento: PLÁSTICO (há deformação permanente).")
            @printf("Deformação elástica (recuperável): %.6f\n", e_elastica)
            @printf("Deformação plástica (permanente): %.6f\n", e_plastica)
        end
    end
       

elseif resposta == 5
    if @isdefined(e)
    @printf("Deformação Total (ε): %.6f\n", e)

    else 
    println("Deformação Total (ε): Não calculada nesta sessão.")
    end

    if @isdefined(sigma)
        @printf("Tensão Aplicada (σ): %.3f Pa\n", sigma)
    else
        println("Tensão Aplicada (σ): Não calculada nesta sessão.")
    end

    if @isdefined(E)
        @printf("Módulo de Elasticidade (E): %.2f Pa\n", E)
        @printf("Deformação Elástica: %.6f\n", e_elastica)
        @printf("Deformação Plástica: %.6f\n", e_plastica)

    else
        println("Propriedades do material: Nenhuma selecionada na Opção 4.")
    end

else 
     @warn "Erro: Digite um numero valido(1 - 5)"
    end
end       

    