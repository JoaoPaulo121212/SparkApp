import Foundation

let dadosExerciciosLocais: [ExercicioLocal] = [
    // --- PEITO ---
    ExercicioLocal(
        nome: "Supino Reto com Barra",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção média)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Barra e Banco Reto",
        instrucoes: [
            "Deite-se no banco reto com os pés firmes no chão e as escápulas retraídas e apoiadas no banco.",
            "Segure a barra com uma pegada um pouco mais afastada que a largura dos ombros, polegares envolvendo a barra.",
            "Retire a barra do suporte e estabilize-a acima do seu peito com os braços estendidos.",
            "Desça a barra de forma controlada até tocar levemente a parte média do seu peito ou chegar próximo.",
            "Os cotovelos devem ficar em um ângulo de aproximadamente 45-70 graus em relação ao tronco, não totalmente abertos nem colados ao corpo.",
            "Empurre a barra de volta à posição inicial, focando na contração do peitoral, até a extensão completa dos cotovelos (sem travá-los).",
            "Mantenha os glúteos no banco durante todo o movimento."
        ],
        observacoes: "Evite bater a barra no peito. A respiração correta é inspirar na descida e expirar na subida.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Supino Reto com Halteres",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção média)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Par de Halteres e Banco Reto",
        instrucoes: [
            "Deite-se no banco reto com um halter em cada mão, apoiados nas coxas.",
            "Com um impulso das coxas, leve os halteres para cima, um de cada vez, até a altura do peito, e então posicione-os acima do peito com os braços estendidos e as palmas das mãos voltadas para frente (ou uma para a outra, dependendo da preferência).",
            "Desça os halteres lentamente e de forma controlada para as laterais do peito, flexionando os cotovelos.",
            "Alongue bem o peitoral na descida, até que os halteres estejam na linha do peito ou ligeiramente abaixo.",
            "Empurre os halteres de volta à posição inicial, contraindo o peitoral.",
            "Mantenha os pés firmes no chão e as escápulas no banco."
        ],
        observacoes: "Halteres permitem maior amplitude de movimento e trabalho estabilizador comparado à barra.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Supino Inclinado com Barra",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção superior/clavicular)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Barra e Banco Inclinado (30-45 graus)",
        instrucoes: [
            "Ajuste o banco para uma inclinação entre 30 a 45 graus.",
            "Deite-se no banco com os pés firmes no chão.",
            "Segure a barra com uma pegada um pouco mais afastada que a largura dos ombros.",
            "Retire a barra e desça-a controladamente até a parte superior do seu peito.",
            "Empurre a barra para cima e ligeiramente para trás, até a extensão dos braços."
        ],
        observacoes: "Foca mais na parte superior do peitoral. Não use uma inclinação excessiva para não sobrecarregar os ombros.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Crucifixo Reto com Halteres",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (ênfase na adução)",
        musculosSecundarios: ["Deltoide Anterior"],
        equipamento: "Par de Halteres e Banco Reto",
        instrucoes: [
            "Deite-se no banco reto com um halter em cada mão, braços estendidos acima do peito, palmas voltadas uma para a outra.",
            "Mantenha uma leve flexão nos cotovelos durante todo o movimento (como se fosse abraçar uma árvore grande).",
            "Abra os braços lentamente, descendo os halteres para as laterais em um arco amplo, até sentir um bom alongamento no peitoral.",
            "Retorne os halteres à posição inicial, usando os músculos do peito para 'espremer' os halteres juntos."
        ],
        observacoes: "Movimento de adução, focado em alongar e contrair o peito. Use cargas moderadas para manter a forma correta.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Peck Deck (Voador Peitoral)",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (ênfase na adução)",
        musculosSecundarios: [],
        equipamento: "Máquina Peck Deck (Voador)",
        instrucoes: [
            "Ajuste o assento da máquina para que os pegadores fiquem na altura do seu peito.",
            "Sente-se com as costas totalmente apoiadas e os pés no chão.",
            "Segure os pegadores com os cotovelos ligeiramente flexionados.",
            "Faça força para juntar os pegadores à frente do corpo, contraindo o peitoral.",
            "Retorne lentamente à posição inicial, controlando o movimento."
        ],
        observacoes: "Ótimo para isolar o peitoral. Mantenha o movimento controlado, evitando que os pesos batam no final.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Crossover (Polia Alta)",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (ênfase nas fibras inferiores e adução)",
        musculosSecundarios: ["Deltoide Anterior"],
        equipamento: "Máquina Crossover com Polias Altas",
        instrucoes: [
            "Posicione as polias na parte mais alta da máquina e selecione o peso desejado.",
            "Segure um pegador em cada mão, posicione-se no centro, ligeiramente à frente das polias.",
            "Incline o tronco levemente para frente, com os pés em base estável e joelhos semiflexionados.",
            "Com os cotovelos levemente flexionados, puxe os cabos para baixo e para frente, cruzando as mãos à frente da parte inferior do abdômen ou quadris.",
            "Concentre-se em 'espremer' o peitoral. Retorne lentamente à posição inicial."
        ],
        observacoes: "Permite uma boa contração e alongamento do peitoral.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Flexão de Braço Clássica",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps", "Abdômen (estabilizador)"],
        equipamento: "Peso Corporal",
        instrucoes: [
            "Deite-se de bruços no chão, com as mãos espalmadas no chão, um pouco mais afastadas que a largura dos ombros.",
            "Estenda os braços, levantando o corpo do chão, mantendo o corpo reto da cabeça aos calcanhares (posição de prancha).",
            "Desça o corpo flexionando os cotovelos, até que o peito quase toque o chão.",
            "Empurre o corpo de volta à posição inicial, estendendo os braços."
        ],
        observacoes: "Excelente exercício com peso corporal. Para iniciantes, pode ser feito com os joelhos no chão.",
        gifUrlLocal: nil
    ),
    // (Adicione mais 7-8 exercícios para Peito aqui)

    // --- COSTAS ---
    ExercicioLocal(
        nome: "Barra Fixa (Pegada Pronada)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal (Latíssimo do Dorso)",
        musculosSecundarios: ["Bíceps", "Trapézio", "Romboides", "Deltoide Posterior"],
        equipamento: "Barra Fixa",
        instrucoes: [
            "Segure a barra com uma pegada pronada (palmas para frente), com as mãos mais afastadas que a largura dos ombros.",
            "Comece com os braços totalmente estendidos, corpo pendurado.",
            "Puxe o corpo para cima, levando o queixo acima da barra. Concentre-se em usar os músculos das costas para iniciar o movimento.",
            "Desça de forma controlada até a extensão completa dos braços."
        ],
        observacoes: "Um dos melhores construtores de massa para as costas. Se for difícil, use assistência (elástico ou máquina).",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Puxada Alta Frontal (Pulley)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal (Latíssimo do Dorso)",
        musculosSecundarios: ["Bíceps", "Trapézio (inferior e médio)", "Romboides"],
        equipamento: "Máquina Pulley com Barra Longa",
        instrucoes: [
            "Sente-se na máquina com os joelhos presos sob o apoio.",
            "Segure a barra com uma pegada pronada, mais afastada que a largura dos ombros.",
            "Incline o tronco levemente para trás (cerca de 15-20 graus).",
            "Puxe a barra para baixo, em direção à parte superior do peito, contraindo as escápulas.",
            "Retorne a barra lentamente à posição inicial, controlando o movimento."
        ],
        observacoes: "Excelente para largura das costas. Evite usar impulso excessivo do corpo.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Curvada com Barra",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal, Romboides, Trapézio (médio)",
        musculosSecundarios: ["Bíceps", "Deltoide Posterior", "Eretores da Espinha (estabilizador)"],
        equipamento: "Barra",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, joelhos levemente flexionados.",
            "Incline o tronco para frente a partir dos quadris, mantendo as costas retas (próximo de paralelo ao chão).",
            "Segure a barra com pegada pronada (ou supinada), mãos na largura dos ombros ou um pouco mais afastadas.",
            "Puxe a barra em direção à parte inferior do seu peito ou abdômen, contraindo as escápulas.",
            "Desça a barra controladamente."
        ],
        observacoes: "Fundamental para espessura das costas. Mantenha a coluna neutra para evitar lesões.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Serrote com Halter (Unilateral)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal",
        musculosSecundarios: ["Bíceps", "Romboides", "Trapézio", "Deltoide Posterior"],
        equipamento: "Halter e Banco Plano",
        instrucoes: [
            "Apoie um joelho e a mão do mesmo lado no banco plano. Mantenha as costas paralelas ao chão.",
            "O outro pé fica firme no chão, perna levemente flexionada.",
            "Segure o halter com a mão livre, braço estendido.",
            "Puxe o halter para cima, em direção à lateral do seu tronco, mantendo o cotovelo próximo ao corpo.",
            "Concentre-se em 'remar' com os músculos das costas, não apenas com o braço.",
            "Desça o halter controladamente. Complete as repetições e troque de lado."
        ],
        observacoes: "Permite grande amplitude e foco unilateral.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Cavalinho (Barra T ou Adaptador)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Meio das Costas (Romboides, Trapézio)",
        musculosSecundarios: ["Grande Dorsal", "Bíceps", "Deltoide Posterior"],
        equipamento: "Barra T ou Barra Olímpica com um canto fixo e pegador V",
        instrucoes: [
            "Posicione a barra T entre as pernas ou use uma barra olímpica com uma extremidade apoiada no canto e um pegador V sob a barra.",
            "Incline o tronco para frente com as costas retas e joelhos flexionados.",
            "Segure os pegadores com os braços estendidos.",
            "Puxe a carga em direção ao seu peito, apertando as escápulas.",
            "Desça controladamente."
        ],
        observacoes: "Excelente para a densidade da parte média das costas.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Hiperextensão Lombar (Banco Romano)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Eretores da Espinha (Lombar)",
        musculosSecundarios: ["Glúteos", "Isquiotibiais"],
        equipamento: "Banco Romano (para hiperextensão)",
        instrucoes: [
            "Ajuste o banco para que a almofada superior fique logo abaixo da linha do quadril.",
            "Posicione-se com os tornozelos presos sob os rolos.",
            "Cruze os braços sobre o peito ou coloque as mãos atrás da cabeça.",
            "Com as costas retas, desça o tronco lentamente até onde for confortável ou até formar um ângulo de 90 graus.",
            "Suba novamente usando os músculos da lombar e glúteos até que seu corpo forme uma linha reta.",
            "Evite hiperextender a coluna na subida."
        ],
        observacoes: "Fortalece a região lombar. Pode ser feito com peso adicional (anilhas) para aumentar a dificuldade.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Pulldown com Braços Retos (Polia Alta)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal (Latíssimo do Dorso)",
        musculosSecundarios: ["Tríceps (cabeça longa)", "Deltoide Posterior"],
        equipamento: "Máquina Pulley com Barra Reta ou Corda",
        instrucoes: [
            "Fique em pé de frente para a polia alta, segurando a barra (ou corda) com os braços estendidos à frente, na altura dos ombros.",
            "Mantenha uma leve flexão nos cotovelos e as costas retas.",
            "Puxe a barra para baixo em um arco, mantendo os braços retos, até que a barra toque suas coxas.",
            "Concentre-se em contrair o grande dorsal. Retorne lentamente à posição inicial."
        ],
        observacoes: "Isola bem o grande dorsal, especialmente a porção inferior.",
        gifUrlLocal: nil
    ),
    // (Adicione mais 7-8 exercícios para Costas aqui)
    // --- OMBROS ---
    ExercicioLocal(
        nome: "Desenvolvimento Militar com Barra (em pé)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide (todas as porções, ênfase anterior e medial)",
        musculosSecundarios: ["Tríceps", "Trapézio Superior", "Core (estabilizador)"],
        equipamento: "Barra",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando a barra na altura da parte superior do peito, com as palmas voltadas para frente e as mãos um pouco mais afastadas que a largura dos ombros.",
            "Mantenha o core ativado e os glúteos contraídos para estabilidade.",
            "Empurre a barra verticalmente para cima até que os braços estejam totalmente estendidos acima da cabeça, sem travar os cotovelos.",
            "Desça a barra de forma controlada de volta à posição inicial, na altura dos ombros/clavícula.",
            "Evite inclinar o tronco excessivamente para trás."
        ],
        observacoes: "Pode ser feito sentado para maior estabilidade, mas em pé recruta mais o core.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Desenvolvimento com Halteres (Sentado ou em Pé)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide (ênfase anterior e medial)",
        musculosSecundarios: ["Tríceps", "Trapézio Superior"],
        equipamento: "Par de Halteres e Banco (opcional)",
        instrucoes: [
            "Sente-se em um banco com encosto (ou fique em pé) segurando um halter em cada mão na altura dos ombros, palmas voltadas para frente.",
            "Mantenha o core firme.",
            "Empurre os halteres verticalmente para cima até que os braços estejam quase totalmente estendidos, sem que os halteres se toquem no topo.",
            "Desça os halteres de forma controlada de volta à altura dos ombros."
        ],
        observacoes: "Permite maior amplitude e movimento mais natural dos ombros em comparação com a barra.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Lateral com Halteres",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Medial (Lateral)",
        musculosSecundarios: ["Deltoide Anterior", "Deltoide Posterior", "Trapézio Superior"],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé (ou sentado) com os pés na largura dos ombros, segurando um halter em cada mão ao lado do corpo, palmas voltadas para dentro.",
            "Mantenha uma leve flexão nos cotovelos.",
            "Eleve os halteres lateralmente até a altura dos ombros, como se estivesse abrindo as asas.",
            "O movimento deve ser focado em levantar os cotovelos, não apenas as mãos.",
            "Desça os halteres de forma controlada até a posição inicial."
        ],
        observacoes: "Evite usar impulso ou balançar o corpo. Concentre-se na contração do deltoide medial.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Frontal com Halteres (Alternada ou Bilateral)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Anterior",
        musculosSecundarios: ["Deltoide Medial", "Peitoral Superior", "Trapézio"],
        equipamento: "Par de Halteres ou Anilha",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando os halteres à frente das coxas com as palmas voltadas para o corpo (ou um halter/anilha com ambas as mãos).",
            "Mantendo os braços quase retos (leve flexão no cotovelo), eleve um halter (ou ambos/anilha) para frente e para cima até a altura dos ombros.",
            "Desça o halter de forma controlada.",
            "Se estiver fazendo alternado, repita com o outro braço."
        ],
        observacoes: "Evite balançar o tronco. O movimento deve ser isolado no ombro.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Posterior Curvado com Halteres (Crucifixo Inverso)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Posterior",
        musculosSecundarios: ["Romboides", "Trapézio Médio"],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, joelhos levemente flexionados.",
            "Incline o tronco para frente a partir dos quadris, mantendo as costas retas, até que o tronco esteja quase paralelo ao chão.",
            "Segure os halteres com os braços estendidos abaixo dos ombros, palmas voltadas uma para a outra.",
            "Mantendo uma leve flexão nos cotovelos, eleve os halteres lateralmente e para cima, como se estivesse abrindo os braços, focando na contração dos deltoides posteriores e músculos do meio das costas.",
            "Desça os halteres de forma controlada."
        ],
        observacoes: "Pode ser feito sentado em um banco com o peito apoiado no encosto inclinado para maior isolamento.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Alta com Barra (ou Halteres/Polia Baixa)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Medial e Trapézio Superior",
        musculosSecundarios: ["Deltoide Anterior", "Bíceps"],
        equipamento: "Barra, Par de Halteres ou Polia Baixa com Barra Reta/Corda",
        instrucoes: [
            "Fique em pé segurando a barra com uma pegada pronada (palmas para baixo), mãos próximas (menor que a largura dos ombros).",
            "Puxe a barra verticalmente para cima, em direção ao queixo, mantendo-a próxima ao corpo.",
            "Os cotovelos devem subir e apontar para fora, ultrapassando a linha dos ombros no final do movimento.",
            "Desça a barra de forma controlada."
        ],
        observacoes: "Cuidado com a execução para não lesionar os ombros. Se sentir desconforto, ajuste a pegada ou o exercício.",
        gifUrlLocal: nil
    ),
    // (Adicione mais exercícios para Ombros)

    // --- BÍCEPS ---
    ExercicioLocal(
        nome: "Rosca Direta com Barra",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial",
        musculosSecundarios: ["Braquial", "Braquiorradial (Antebraço)"],
        equipamento: "Barra Reta ou Barra W",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando a barra com pegada supinada (palmas para cima), mãos na largura dos ombros.",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione os cotovelos, elevando a barra em direção aos ombros.",
            "Contraia o bíceps no topo do movimento.",
            "Desça a barra de forma controlada até a extensão quase completa dos braços."
        ],
        observacoes: "Evite balançar o corpo ou usar impulso. A barra W pode ser mais confortável para os punhos.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Alternada com Halteres (em pé ou sentado)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial",
        musculosSecundarios: ["Braquial", "Braquiorradial"],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé ou sentado, segurando um halter em cada mão ao lado do corpo, palmas voltadas para frente (ou para o corpo, supinando durante o movimento).",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione um cotovelo, elevando o halter em direção ao ombro. Pode-se girar o punho (supinar) durante a subida se começou com pegada neutra.",
            "Contraia o bíceps no topo.",
            "Desça o halter controladamente. Repita com o outro braço."
        ],
        observacoes: "Permite maior foco em cada braço e variação na pegada.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Concentrada com Halter",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial (ênfase no pico)",
        musculosSecundarios: ["Braquial"],
        equipamento: "Halter e Banco",
        instrucoes: [
            "Sente-se em um banco com as pernas afastadas.",
            "Segure um halter com uma mão e apoie a parte de trás do braço (tríceps) na parte interna da coxa do mesmo lado.",
            "Deixe o braço estender completamente.",
            "Flexione o cotovelo, trazendo o halter em direção ao ombro.",
            "Contraia o bíceps no topo e desça lentamente."
        ],
        observacoes: "Excelente para isolar o bíceps e trabalhar o 'pico'.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Martelo com Halteres",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Braquial e Braquiorradial",
        musculosSecundarios: ["Bíceps Braquial"],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé ou sentado, segurando um halter em cada mão com pegada neutra (palmas voltadas para o corpo).",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione os cotovelos, elevando os halteres em direção aos ombros, sem girar os punhos.",
            "Contraia os músculos no topo e desça controladamente."
        ],
        observacoes: "Trabalha mais o músculo braquial (abaixo do bíceps) e o braquiorradial (antebraço), ajudando na espessura do braço.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Scott com Barra (ou Halteres)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial (ênfase na porção curta)",
        musculosSecundarios: ["Braquial"],
        equipamento: "Banco Scott e Barra W (ou Reta/Halteres)",
        instrucoes: [
            "Sente-se no banco Scott, ajustando a altura para que as axilas fiquem apoiadas no topo do suporte inclinado.",
            "Segure a barra W (ou halteres) com pegada supinada.",
            "Os braços devem estar totalmente apoiados no suporte.",
            "Desça a barra lentamente até quase a extensão completa dos braços, sentindo o bíceps alongar.",
            "Flexione os cotovelos, trazendo a barra em direção aos ombros, contraindo o bíceps.",
            "Não use impulso."
        ],
        observacoes: "Isola muito bem o bíceps, minimizando o uso de outros músculos.",
        gifUrlLocal: nil
    ),
    // (Adicione mais exercícios para Bíceps)

    // --- TRÍCEPS ---
    ExercicioLocal(
        nome: "Tríceps Testa com Barra W (ou Reta)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (todas as cabeças)",
        musculosSecundarios: [],
        equipamento: "Barra W ou Reta e Banco Reto",
        instrucoes: [
            "Deite-se em um banco reto, segurando a barra W (ou reta) com uma pegada fechada (mãos próximas), braços estendidos acima do peito.",
            "Mantenha os cotovelos apontados para cima e relativamente fixos.",
            "Flexione os cotovelos, descendo a barra em direção à testa ou logo acima da cabeça.",
            "Empurre a barra de volta à posição inicial, estendendo os cotovelos e contraindo o tríceps."
        ],
        observacoes: "Cuidado para não bater a barra na testa. Pode ser feito com halteres ('skullcrusher' com halteres).",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Tríceps Francês Unilateral com Halter (Sentado ou em Pé)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase na cabeça longa)",
        musculosSecundarios: [],
        equipamento: "Halter e Banco (opcional)",
        instrucoes: [
            "Sente-se ou fique em pé, segurando um halter com uma mão.",
            "Estenda o braço com o halter acima da cabeça.",
            "Mantenha o cotovelo próximo à cabeça e aponte-o para o teto.",
            "Flexione o cotovelo, descendo o halter atrás da cabeça.",
            "Estenda o braço de volta à posição inicial, contraindo o tríceps.",
            "Repita e depois troque de braço."
        ],
        observacoes: "Bom para alongar e trabalhar a cabeça longa do tríceps.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Supino Fechado com Barra",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial",
        musculosSecundarios: ["Peitoral Maior (interno)", "Deltoide Anterior"],
        equipamento: "Barra e Banco Reto",
        instrucoes: [
            "Deite-se no banco reto, segurando a barra com uma pegada pronada e mãos na largura dos ombros ou um pouco mais próximas.",
            "Retire a barra do suporte e posicione-a acima do peito.",
            "Desça a barra em direção à parte inferior do peito, mantendo os cotovelos relativamente próximos ao corpo.",
            "Empurre a barra de volta à posição inicial, focando na extensão dos cotovelos e contração do tríceps."
        ],
        observacoes: "Excelente exercício composto para o tríceps, também trabalha peito e ombros.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Mergulho nas Paralelas (Tríceps Dips)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial",
        musculosSecundarios: ["Peitoral Inferior", "Deltoide Anterior"],
        equipamento: "Barras Paralelas",
        instrucoes: [
            "Posicione-se nas barras paralelas com os braços estendidos e corpo reto.",
            "Flexione os cotovelos, descendo o corpo até que os ombros fiquem na altura dos cotovelos ou um pouco abaixo.",
            "Mantenha o tronco o mais vertical possível para focar no tríceps (inclinar para frente foca mais no peito).",
            "Empurre o corpo de volta à posição inicial, estendendo os braços."
        ],
        observacoes: "Exercício intenso com peso corporal. Pode-se adicionar peso com um cinto se ficar fácil.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Tríceps Pulley com Corda (ou Barra Reta)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase na cabeça lateral e medial)",
        musculosSecundarios: [],
        equipamento: "Máquina Pulley com Corda ou Barra Reta",
        instrucoes: [
            "Fique em pé de frente para a polia alta, segurando a corda (ou barra) com as palmas voltadas para baixo ou uma para a outra (corda).",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Empurre a corda/barra para baixo, estendendo completamente os cotovelos.",
            "Contraia o tríceps no final do movimento. Se usar corda, afaste as mãos no final.",
            "Retorne lentamente à posição inicial."
        ],
        observacoes: "Bom para isolamento e definição do tríceps.",
        gifUrlLocal: nil
    ),
    // (Adicione mais exercícios para Tríceps)

    // --- PERNAS ---
    ExercicioLocal(
        nome: "Agachamento Livre com Barra",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps, Glúteos",
        musculosSecundarios: ["Isquiotibiais", "Panturrilhas", "Eretores da Espinha", "Abdômen"],
        equipamento: "Barra e Suporte de Agachamento (Rack)",
        instrucoes: [
            "Posicione a barra sobre os trapézios (barra alta) ou deltoides posteriores (barra baixa).",
            "Afaste os pés na largura dos ombros, pontas dos pés levemente para fora.",
            "Mantenha o peito erguido e as costas retas/neutras.",
            "Desça flexionando os joelhos e quadris, como se fosse sentar em uma cadeira, até que as coxas fiquem paralelas ao chão ou mais baixo, se possível.",
            "Os joelhos devem seguir a direção dos pés.",
            "Suba estendendo os joelhos e quadris, voltando à posição inicial."
        ],
        observacoes: "Exercício fundamental para força e massa nas pernas e glúteos. A técnica correta é crucial.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Leg Press 45°",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps",
        musculosSecundarios: ["Glúteos", "Isquiotibiais"],
        equipamento: "Máquina Leg Press 45°",
        instrucoes: [
            "Sente-se na máquina com as costas e cabeça apoiadas.",
            "Coloque os pés na plataforma na largura dos ombros (ou variando para diferentes ênfases).",
            "Destrave a segurança e empurre a plataforma até estender quase totalmente os joelhos (não trave).",
            "Desça a plataforma lentamente, flexionando os joelhos, até formar um ângulo de 90 graus ou um pouco mais.",
            "Empurre de volta à posição inicial."
        ],
        observacoes: "Permite usar cargas elevadas com menor estresse na lombar comparado ao agachamento.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Cadeira Extensora",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps",
        musculosSecundarios: [],
        equipamento: "Máquina Extensora",
        instrucoes: [
            "Sente-se na máquina com os joelhos alinhados com o eixo de rotação da máquina e o apoio dos tornozelos posicionado corretamente.",
            "Segure as manoplas laterais para estabilidade.",
            "Estenda as pernas completamente, contraindo o quadríceps no topo.",
            "Desça o peso de forma controlada."
        ],
        observacoes: "Exercício de isolamento para o quadríceps.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Mesa Flexora (Isquiotibiais Deitado)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Isquiotibiais",
        musculosSecundarios: ["Panturrilhas", "Glúteos (levemente)"],
        equipamento: "Máquina Flexora Deitada",
        instrucoes: [
            "Deite-se de bruços na máquina, com os joelhos logo abaixo da borda do banco e os tornozelos sob o rolo de apoio.",
            "Segure as manoplas para estabilidade.",
            "Flexione os joelhos, trazendo os calcanhares em direção aos glúteos.",
            "Contraia os isquiotibiais no topo.",
            "Desça o peso lentamente e de forma controlada."
        ],
        observacoes: "Isola bem os isquiotibiais.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Stiff com Barra (ou Halteres)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Isquiotibiais e Glúteos",
        musculosSecundarios: ["Eretores da Espinha (Lombar)"],
        equipamento: "Barra ou Par de Halteres",
        instrucoes: [
            "Fique em pé segurando a barra (ou halteres) à frente do corpo, com as mãos na largura dos ombros e pegada pronada.",
            "Mantenha os joelhos levemente flexionados (quase retos, mas não travados) durante todo o movimento.",
            "Incline o tronco para frente a partir dos quadris, mantendo as costas retas e a barra próxima às pernas.",
            "Desça até sentir um bom alongamento nos isquiotibiais ou até o tronco ficar paralelo ao chão.",
            "Retorne à posição inicial contraindo os glúteos e isquiotibiais, mantendo as costas retas."
        ],
        observacoes: "Excelente para a cadeia posterior. Não confunda com o Levantamento Terra convencional.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Pélvica com Barra (Hip Thrust)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Glúteos",
        musculosSecundarios: ["Isquiotibiais", "Eretores da Espinha"],
        equipamento: "Barra, Banco e Apoio para Barra (opcional)",
        instrucoes: [
            "Sente-se no chão com as costas (região das escápulas) apoiadas na lateral de um banco.",
            "Coloque uma barra sobre a região pélvica (use um acolchoado para conforto).",
            "Os pés devem estar firmes no chão, joelhos flexionados.",
            "Empurre os quadris para cima, elevando a barra até que seu corpo forme uma linha reta dos ombros aos joelhos.",
            "Contraia fortemente os glúteos no topo.",
            "Desça os quadris controladamente."
        ],
        observacoes: "Um dos melhores exercícios para desenvolvimento dos glúteos.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Panturrilha em Pé (Máquina ou Livre)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Panturrilhas (Gastrocnêmio)",
        musculosSecundarios: ["Sóleo"],
        equipamento: "Máquina de Panturrilha em Pé, Barra, Halteres ou Step",
        instrucoes: [
            "Posicione-se na máquina com os ombros sob os apoios e a ponta dos pés na plataforma, calcanhares para fora.",
            "Ou fique em pé com uma barra nas costas ou halteres nas mãos, ponta dos pés em um step.",
            "Mantenha os joelhos levemente flexionados ou estendidos.",
            "Eleve os calcanhares o máximo possível, contraindo as panturrilhas.",
            "Desça lentamente, alongando bem as panturrilhas."
        ],
        observacoes: "Varie a posição dos pés (para dentro, para fora, retos) para diferentes ênfases.",
        gifUrlLocal: nil
    ),
    // (Adicione mais exercícios para Pernas)

    // --- ABDÔMEN ---
    ExercicioLocal(
        nome: "Crunch Abdominal (Supra)",
        grupoMuscular: "Abdômen",
        musculoPrincipal: "Reto Abdominal (parte superior)",
        musculosSecundarios: ["Oblíquos (levemente)"],
        equipamento: "Colchonete (opcional)",
        instrucoes: [
            "Deite-se de costas com os joelhos flexionados e os pés apoiados no chão (ou elevados).",
            "Coloque as mãos atrás da cabeça (sem puxar o pescoço) ou cruzadas sobre o peito.",
            "Contraia o abdômen para elevar a cabeça e os ombros do chão, curvando a parte superior das costas.",
            "Concentre-se em 'esmagar' o abdômen. Mantenha a lombar em contato com o chão.",
            "Desça lentamente."
        ],
        observacoes: "Movimento curto e concentrado. Evite usar o pescoço para subir.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação de Pernas Deitado (Infra)",
        grupoMuscular: "Abdômen",
        musculoPrincipal: "Reto Abdominal (parte inferior)",
        musculosSecundarios: ["Flexores do Quadril"],
        equipamento: "Colchonete (opcional)",
        instrucoes: [
            "Deite-se de costas com as pernas estendidas e as mãos sob os glúteos para apoio ou ao lado do corpo.",
            "Mantenha as pernas retas (ou levemente flexionadas) e eleve-as até formarem um ângulo de 90 graus com o tronco.",
            "Desça as pernas lentamente, quase tocando o chão, sem deixar a lombar arquear.",
            "Mantenha o abdômen contraído durante todo o movimento."
        ],
        observacoes: "Para dificultar, não deixe os calcanhares tocarem o chão entre as repetições.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Prancha Frontal",
        grupoMuscular: "Abdômen",
        musculoPrincipal: "Core (Reto Abdominal, Transverso, Oblíquos)",
        musculosSecundarios: ["Eretores da Espinha", "Ombros", "Glúteos"],
        equipamento: "Peso Corporal",
        instrucoes: [
            "Deite-se de bruços, apoie os antebraços no chão com os cotovelos alinhados abaixo dos ombros e as mãos entrelaçadas ou espalmadas.",
            "Eleve o corpo, apoiando-se nos antebraços e nas pontas dos pés.",
            "Mantenha o corpo reto da cabeça aos calcanhares, contraindo o abdômen e os glúteos.",
            "Evite deixar o quadril cair ou elevar demais.",
            "Mantenha a posição pelo tempo desejado."
        ],
        observacoes: "Excelente exercício isométrico para fortalecer o core.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Abdominal Russo (Russian Twist)",
        grupoMuscular: "Abdômen",
        musculoPrincipal: "Oblíquos",
        musculosSecundarios: ["Reto Abdominal", "Flexores do Quadril"],
        equipamento: "Peso Corporal, Anilha ou Medicine Ball (opcional)",
        instrucoes: [
            "Sente-se no chão com os joelhos flexionados e os pés levemente fora do chão (ou apoiados para facilitar).",
            "Incline o tronco para trás, formando um V com as coxas, mantendo as costas retas.",
            "Junte as mãos à frente do peito (ou segure um peso).",
            "Gire o tronco de um lado para o outro, tocando (ou quase tocando) as mãos/peso no chão ao lado do quadril.",
            "Mantenha o abdômen contraído."
        ],
        observacoes: "Controle o movimento, não use apenas o embalo dos braços.",
        gifUrlLocal: nil
    )
    // (Adicione mais exercícios para Abdômen)
    ]
