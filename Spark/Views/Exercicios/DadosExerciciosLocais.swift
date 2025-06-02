import Foundation

let dadosExerciciosLocais: [ExercicioLocal] = [
    // --- PEITO ---
    ExercicioLocal(
        nome: "Supino Reto na máquina",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção média)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Máquina de supino reto",
        instrucoes: [
            "Apoie-se no banco com as pernas afastadas e apoie bem os pes no chao no chão.",
            "Contraia as escapulas e não solte até o fim da série",
            "Segure os pegadores com uma pegada confortável, empurrando a carga para frente até quase estender os braços.",
            "Faça força com os pés para baixo. Isso irá te dar mais força durante sua execução.",
        ],
        observacoes: "Evite que seus ombros subam durante a execução.",
        gifUrlLocal: nil
    ),
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
        nome: "Crucifixo máquina (Peck Deck)",
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
    // --- Novos exercícios para Peito ---
    ExercicioLocal(
        nome: "Supino Declinado com Barra",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção inferior)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Barra e Banco Declinado",
        instrucoes: [
            "Deite-se no banco declinado, prendendo os pés nos suportes.",
            "Segure a barra com uma pegada um pouco mais afastada que a largura dos ombros.",
            "Retire a barra do suporte e desça-a controladamente em direção à parte inferior do peito.",
            "Empurre a barra de volta à posição inicial, focando na contração do peitoral inferior."
        ],
        observacoes: "Foca na parte inferior do peitoral. Tenha certeza de que os pés estão bem fixos.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Crucifixo Inclinado com Halteres",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção superior)",
        musculosSecundarios: ["Deltoide Anterior"],
        equipamento: "Par de Halteres e Banco Inclinado",
        instrucoes: [
            "Deite-se em um banco inclinado (30-45 graus) com um halter em cada mão, braços estendidos acima do peito, palmas voltadas uma para a outra.",
            "Mantenha uma leve flexão nos cotovelos.",
            "Abra os braços lentamente, descendo os halteres para as laterais em um arco amplo, até sentir um bom alongamento no peitoral superior.",
            "Retorne os halteres à posição inicial, usando os músculos do peito para 'espremer' os halteres juntos acima do peito."
        ],
        observacoes: "Ótimo para alongamento e isolamento da parte superior do peito.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Crossover (Polia Baixa)",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (ênfase nas fibras superiores e adução)",
        musculosSecundarios: ["Deltoide Anterior"],
        equipamento: "Máquina Crossover com Polias Baixas",
        instrucoes: [
            "Posicione as polias na parte mais baixa da máquina e selecione o peso desejado.",
            "Segure um pegador em cada mão, posicione-se no centro, ligeiramente atrás das polias.",
            "Incline o tronco levemente para frente, com os pés em base estável e joelhos semiflexionados.",
            "Com os cotovelos levemente flexionados, puxe os cabos para cima e para frente, cruzando as mãos à frente da parte superior do peito ou altura dos ombros.",
            "Concentre-se em 'espremer' o peitoral superior. Retorne lentamente à posição inicial."
        ],
        observacoes: "Enfatiza a parte superior do peitoral, ideal para sua definição.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Flexão de Braço com Pegada Fechada",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção interna)",
        musculosSecundarios: ["Tríceps", "Deltoide Anterior"],
        equipamento: "Peso Corporal",
        instrucoes: [
            "Deite-se de bruços no chão, com as mãos espalmadas no chão, mais próximas que a largura dos ombros (logo abaixo do peito).",
            "Mantenha o corpo reto da cabeça aos calcanhares.",
            "Desça o corpo flexionando os cotovelos, mantendo-os próximos ao corpo, até que o peito quase toque o chão.",
            "Empurre o corpo de volta à posição inicial, estendendo os braços e focando na contração do peitoral interno e tríceps."
        ],
        observacoes: "Excelente para ativar o tríceps e a parte central do peito. Se for difícil, faça com os joelhos no chão.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Pull Over com Halter (Reto ou Inclinado)",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (parte externa) e Grande Dorsal",
        musculosSecundarios: ["Tríceps (cabeça longa)", "Serrátil Anterior"],
        equipamento: "Um Halter e Banco Reto (ou inclinado)",
        instrucoes: [
            "Deite-se no banco reto com a cabeça na extremidade, ou deitado de lado (perpendicular ao banco) para maior estabilidade.",
            "Segure um halter com as duas mãos, uma sobre a outra, com os braços estendidos acima do peito (cotovelos levemente flexionados).",
            "Desça o halter em um arco sobre a cabeça, alongando o peitoral e as costas.",
            "Puxe o halter de volta à posição inicial, contraindo o peito e as costas."
        ],
        observacoes: "É um exercício que trabalha tanto o peitoral quanto o latíssimo do dorso, ideal para expansão da caixa torácica e flexibilidade do ombro.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Flexão de Braço com Pés Elevados",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção superior)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps", "Abdômen (estabilizador)"],
        equipamento: "Peso Corporal e Banco/Step",
        instrucoes: [
            "Posicione os pés em um banco ou step elevado, com as mãos no chão um pouco mais afastadas que a largura dos ombros.",
            "Mantenha o corpo reto da cabeça aos calcanhares.",
            "Desça o corpo flexionando os cotovelos, até que o peito quase toque o chão.",
            "Empurre o corpo de volta à posição inicial, estendendo os braços. Quanto mais alta a elevação dos pés, maior a ênfase no peitoral superior."
        ],
        observacoes: "Versão mais desafiadora da flexão, ideal para enfatizar a parte superior do peito.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Supino Inclinado com Halteres",
        grupoMuscular: "Peito",
        musculoPrincipal: "Peitoral Maior (porção superior)",
        musculosSecundarios: ["Deltoide Anterior", "Tríceps"],
        equipamento: "Par de Halteres e Banco Inclinado (30-45 graus)",
        instrucoes: [
            "Ajuste o banco para uma inclinação entre 30 a 45 graus.",
            "Deite-se no banco com um halter em cada mão, apoiados nas coxas.",
            "Com um impulso das coxas, leve os halteres para cima, um de cada vez, até a altura do peito, e então posicione-os acima do peito com os braços estendidos e as palmas das mãos voltadas para frente.",
            "Desça os halteres lentamente e de forma controlada para as laterais do peito, flexionando os cotovelos, até a linha do peito ou ligeiramente abaixo.",
            "Empurre os halteres de volta à posição inicial, contraindo o peitoral superior.",
            "Mantenha os pés firmes no chão e as escápulas no banco."
        ],
        observacoes: "Permite maior amplitude de movimento e foco unilateral para o peitoral superior.",
        gifUrlLocal: nil
    ),

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
    // --- Novos exercícios para Costas ---
    ExercicioLocal(
        nome: "Puxada com Pegada Supinada (Pulley)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal (ênfase na porção inferior e largura)",
        musculosSecundarios: ["Bíceps", "Trapézio"],
        equipamento: "Máquina Pulley com Barra Reta",
        instrucoes: [
            "Sente-se na máquina com os joelhos presos sob o apoio.",
            "Segure a barra com uma pegada supinada (palmas para você), mãos na largura dos ombros ou ligeiramente mais próximas.",
            "Incline o tronco levemente para trás (cerca de 15-20 graus).",
            "Puxe a barra para baixo em direção à parte inferior do peito, contraindo as escápulas e levando os cotovelos para baixo e para trás.",
            "Retorne a barra lentamente à posição inicial, controlando o movimento."
        ],
        observacoes: "Coloca mais ênfase na parte inferior do latíssimo do dorso e no bíceps.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Baixa (Remada Sentada na Polia)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal, Romboides, Trapézio (médio)",
        musculosSecundarios: ["Bíceps", "Deltoide Posterior"],
        equipamento: "Máquina de Remada Sentada com Pegador V",
        instrucoes: [
            "Sente-se na máquina com os pés apoiados na plataforma e os joelhos levemente flexionados.",
            "Segure o pegador V com as mãos. Mantenha as costas retas e o tronco levemente inclinado para frente.",
            "Puxe o pegador em direção ao seu abdômen, retraindo as escápulas e levando os cotovelos para trás, espremendo as costas.",
            "Retorne o peso lentamente e de forma controlada, alongando as costas sem arredondar a lombar."
        ],
        observacoes: "Excelente para espessura das costas. Permite variar a pegada para diferentes ênfases.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Invertida (Remada Australiana)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal, Romboides, Trapézio",
        musculosSecundarios: ["Bíceps", "Deltoide Posterior", "Core (estabilizador)"],
        equipamento: "Barra Baixa (Smith ou Suporte)",
        instrucoes: [
            "Posicione uma barra em um suporte baixo (altura da cintura ou do peito).",
            "Deite-se de costas no chão sob a barra, segurando-a com as mãos um pouco mais afastadas que a largura dos ombros (pegada pronada).",
            "Mantenha o corpo reto da cabeça aos calcanhares, apoiado nos calcanhares (ou pés inteiros para facilitar).",
            "Puxe o peito em direção à barra, contraindo as escápulas e usando os músculos das costas.",
            "Desça o corpo controladamente. Para aumentar a dificuldade, eleve os pés ou use uma barra mais baixa."
        ],
        observacoes: "Ótimo exercício com peso corporal para as costas, escalável para todos os níveis.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Alta Invertida na Polia (Face Pull)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Deltoide Posterior, Trapézio (médio e inferior)",
        musculosSecundarios: ["Romboides", "Bíceps (cabeça longa)"],
        equipamento: "Máquina Polia Alta com Corda",
        instrucoes: [
            "Posicione a polia na altura dos ombros ou um pouco acima.",
            "Segure a corda com uma pegada neutra (palmas para dentro).",
            "Dê um passo para trás para criar tensão no cabo. Mantenha os joelhos levemente flexionados e o core ativado.",
            "Puxe a corda em direção ao seu rosto, separando as extremidades da corda enquanto puxa. Os cotovelos devem apontar para fora e para trás.",
            "Concentre-se em apertar as escápulas e contrair o deltoide posterior. Retorne lentamente à posição inicial."
        ],
        observacoes: "Excelente para a saúde dos ombros e para fortalecer os músculos da parte superior das costas, muitas vezes negligenciados.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Remada Inclinada com Halteres (Unilateral ou Bilateral)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal, Romboides, Trapézio",
        musculosSecundarios: ["Bíceps", "Deltoide Posterior"],
        equipamento: "Par de Halteres e Banco Inclinado (opcional)",
        instrucoes: [
            "Deite-se de bruços em um banco inclinado (30-45 graus), com o peito apoiado no banco, segurando um halter em cada mão com os braços estendidos para baixo.",
            "Ou fique em pé, inclinando o tronco para frente com as costas retas e joelhos flexionados, segurando um halter em cada mão.",
            "Puxe os halteres para cima em direção às laterais do tronco, apertando as escápulas.",
            "Desça os halteres controladamente."
        ],
        observacoes: "Boa opção para isolar as costas sem sobrecarregar a lombar (se feito no banco).",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Terra (Levantamento Terra)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Eretores da Espinha, Glúteos, Isquiotibiais",
        musculosSecundarios: ["Grande Dorsal", "Trapézio", "Quadríceps", "Antebraços"],
        equipamento: "Barra e Anilhas",
        instrucoes: [
            "Posicione a barra à frente dos seus pés (próximo às canelas).",
            "Agache-se, mantendo as costas retas e o peito para cima.",
            "Segure a barra com uma pegada pronada (ou mista), mãos ligeiramente mais afastadas que a largura dos ombros.",
            "Mantenha o core ativado. Levante a barra do chão estendendo os quadris e joelhos simultaneamente, puxando os ombros para trás e para baixo.",
            "Mantenha a barra próxima ao corpo durante a subida. Não arredonde as costas.",
            "Abaixe a barra controladamente, revertendo o movimento."
        ],
        observacoes: "Exercício composto de corpo inteiro, um dos mais eficazes para força e massa muscular. Requer técnica impecável para evitar lesões.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Puxada Frontal com Pegada Neutra (Máquina Pulley)",
        grupoMuscular: "Costas",
        musculoPrincipal: "Grande Dorsal (ênfase na largura e porção inferior)",
        musculosSecundarios: ["Bíceps", "Trapézio"],
        equipamento: "Máquina Pulley com Pegador Neutro (V ou paralelas)",
        instrucoes: [
            "Sente-se na máquina com os joelhos presos sob o apoio.",
            "Segure o pegador neutro (palmas uma para a outra) com as mãos.",
            "Incline o tronco levemente para trás (cerca de 15-20 graus).",
            "Puxe o pegador para baixo em direção à parte superior do peito, contraindo as escápulas e levando os cotovelos para baixo e para trás.",
            "Retorne o pegador lentamente à posição inicial, controlando o movimento e alongando as costas."
        ],
        observacoes: "A pegada neutra pode ser mais confortável para os ombros de algumas pessoas e oferece uma variação no estímulo muscular.",
        gifUrlLocal: nil
    ),

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
        nome: "Desenvolvimento com Halteres",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide (ênfase anterior e medial)",
        musculosSecundarios: ["Tríceps", "Trapézio Superior"],
        equipamento: "Par de Halteres e Banco",
        instrucoes: [
            "Sente-se em um banco com encosto segurando um halter em cada mão apoie-os em sua coxa, palmas voltadas para você (pegada neutra).",
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
    // --- Novos exercícios para Ombros ---
    ExercicioLocal(
        nome: "Elevação Lateral na Polia",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Medial",
        musculosSecundarios: ["Trapézio Superior"],
        equipamento: "Máquina de Polia Baixa",
        instrucoes: [
            "Fique de lado para a máquina de polia, com a polia na posição mais baixa.",
            "Segure o pegador com a mão mais distante da polia, cruzando o braço na frente do corpo.",
            "Mantenha uma leve flexão no cotovelo e eleve o braço lateralmente até a altura do ombro, como se estivesse abrindo as asas.",
            "Concentre-se em isolar o deltoide medial. Desça o peso de forma controlada."
        ],
        observacoes: "Oferece tensão constante no músculo, diferente dos halteres. Pode ser feito unilateralmente para maior foco.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Frontal na Polia",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Anterior",
        musculosSecundarios: [],
        equipamento: "Máquina de Polia Baixa",
        instrucoes: [
            "Fique de frente para a máquina de polia, com a polia na posição mais baixa.",
            "Segure o pegador com uma das mãos, com a palma voltada para baixo.",
            "Mantenha o braço quase reto (leve flexão no cotovelo) e eleve o braço para frente e para cima até a altura do ombro.",
            "Desça o peso de forma controlada. Faça com uma mão de cada vez para maior isolamento."
        ],
        observacoes: "Semelhante à elevação frontal com halteres, mas com tensão constante, o que pode ser bom para a conexão mente-músculo.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Desenvolvimento Arnold com Halteres",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide (todas as porções)",
        musculosSecundarios: ["Tríceps", "Trapézio Superior"],
        equipamento: "Par de Halteres e Banco (opcional)",
        instrucoes: [
            "Sente-se em um banco com encosto (ou fique em pé) segurando um halter em cada mão na altura dos ombros, com as palmas voltadas para você.",
            "Ao empurrar os halteres para cima, gire os punhos para que as palmas fiquem voltadas para frente no topo do movimento.",
            "Estenda os braços quase completamente acima da cabeça.",
            "Ao descer, gire os punhos de volta à posição inicial (palmas voltadas para você), descendo os halteres até a altura dos ombros."
        ],
        observacoes: "Combina o desenvolvimento com rotação, ativando as três cabeças do deltoide de forma mais completa.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Encolhimento com Halteres",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Trapézio Superior",
        musculosSecundarios: [],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando um halter em cada mão ao lado do corpo.",
            "Mantenha os braços estendidos e o tronco reto.",
            "Eleve os ombros em direção às orelhas, contraindo o trapézio superior.",
            "Mantenha a contração por um segundo e desça os ombros lentamente, sentindo o alongamento."
        ],
        observacoes: "Focado no trapézio superior, importante para a estética e força dos ombros e pescoço. Evite girar os ombros.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Encolhimento com Barra",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Trapézio Superior",
        musculosSecundarios: [],
        equipamento: "Barra",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando a barra à frente do corpo com uma pegada pronada (palmas para baixo), mãos na largura dos ombros.",
            "Mantenha os braços estendidos e o tronco reto.",
            "Eleve os ombros em direção às orelhas, contraindo o trapézio superior.",
            "Mantenha a contração por um segundo e desça os ombros lentamente, sentindo o alongamento."
        ],
        observacoes: "Permite usar mais carga do que com halteres. Focado no trapézio superior para espessura.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Crucifixo Inverso na Máquina (Máquina de Peito Inverso)",
        grupoMuscular: "Ombros",
        musculoPrincipal: "Deltoide Posterior",
        musculosSecundarios: ["Romboides", "Trapézio Médio"],
        equipamento: "Máquina de Peito Inverso (Fly Reverso)",
        instrucoes: [
            "Sente-se na máquina de peito inverso, com o peito apoiado no encosto.",
            "Segure os pegadores com os braços estendidos para a frente, palmas voltadas uma para a outra ou para baixo.",
            "Puxe os pegadores para trás, abrindo os braços para as laterais, focando na contração dos deltoides posteriores e das escápulas.",
            "Retorne o peso lentamente e de forma controlada à posição inicial."
        ],
        observacoes: "Ótimo para isolar o deltoide posterior e melhorar a postura, minimizando a trapaça.",
        gifUrlLocal: nil
    ),

    // --- BÍCEPS ---
    ExercicioLocal(
        nome: "Rosca martelo",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps cabeça longa",
        musculosSecundarios: ["Cabeça longa", "Braquiorradial (Antebraço)"],
        equipamento: "Halteres ou Corda na Polia",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando os halteres com pegada neutra (palmas voltadas para você), mãos na largura dos ombros.",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione os cotovelos, elevando os halteres/corda em direção aos ombros.",
            "Contraia o bíceps no topo do movimento.",
            "Desça os halteres/corda de forma controlada até a extensão quase completa dos braços."
        ],
        observacoes: "Evite balançar o corpo ou usar impulso. Os halteres podem ser mais confortaveis para os punhos.",
        gifUrlLocal: nil
    ),
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
        nome: "Rosca Alternada com Halteres",
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
    // --- Novos exercícios para Bíceps ---
    ExercicioLocal(
        nome: "Rosca Polia Baixa (com Barra Reta ou Corda)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial",
        musculosSecundarios: ["Braquial", "Braquiorradial"],
        equipamento: "Máquina de Polia Baixa com Barra Reta ou Corda",
        instrucoes: [
            "Fique em pé de frente para a polia baixa, segurando a barra reta (ou corda) com uma pegada supinada (palmas para cima) ou neutra (corda).",
            "Mantenha os cotovelos fixos ao lado do corpo e o tronco ereto.",
            "Flexione os cotovelos, elevando a barra/corda em direção aos ombros, contraindo o bíceps no topo.",
            "Desça a barra/corda de forma controlada até a extensão quase completa dos braços."
        ],
        observacoes: "Proporciona tensão constante no bíceps durante todo o movimento.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Inclinada com Halteres",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial (ênfase na cabeça longa)",
        musculosSecundarios: ["Braquial"],
        equipamento: "Par de Halteres e Banco Inclinado (45-60 graus)",
        instrucoes: [
            "Sente-se em um banco inclinado (45-60 graus) com um halter em cada mão, deixando os braços estendidos para baixo, palmas voltadas para a frente.",
            "Mantenha a parte superior dos braços fixa e os cotovelos apontando para baixo.",
            "Flexione os cotovelos, elevando os halteres em direção aos ombros.",
            "Contraia o bíceps no topo e desça lentamente até a extensão completa dos braços, sentindo o alongamento."
        ],
        observacoes: "A posição inclinada alonga mais a cabeça longa do bíceps, o que pode levar a um maior recrutamento dessa porção.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca 21 (Barra W ou Reta)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial (foco em todas as partes do movimento)",
        musculosSecundarios: ["Braquial", "Braquiorradial"],
        equipamento: "Barra W ou Reta",
        instrucoes: [
            "É uma série de 21 repetições divididas em três fases:",
            "Fase 1 (7 reps): Fique em pé, segurando a barra com pegada supinada. Faça 7 repetições flexionando os cotovelos da posição inicial (braços estendidos) até a metade do movimento (cotovelos a 90 graus).",
            "Fase 2 (7 reps): Imediatamente após, faça 7 repetições começando da metade do movimento (cotovelos a 90 graus) até a contração máxima (barra perto dos ombros).",
            "Fase 3 (7 reps): Por fim, faça 7 repetições de amplitude total, desde os braços estendidos até a contração máxima.",
            "Mantenha o controle e evite impulso em todas as fases."
        ],
        observacoes: "Excelente para a intensidade e 'pump' no bíceps, trabalhando diferentes pontos da curva de força.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Inversa com Barra (ou Halteres)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Braquiorradial (Antebraço)",
        musculosSecundarios: ["Braquial", "Bíceps Braquial"],
        equipamento: "Barra Reta ou Barra W (ou Halteres)",
        instrucoes: [
            "Fique em pé, segurando a barra (ou halteres) com uma pegada pronada (palmas para baixo), mãos na largura dos ombros.",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione os cotovelos, elevando a barra em direção aos ombros, mantendo as palmas para baixo.",
            "Desça a barra de forma controlada até a extensão quase completa dos braços."
        ],
        observacoes: "Foca nos músculos do antebraço (braquiorradial) e no braquial, dando espessura ao braço.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca Cabo de Duas Mãos (Polia Baixa)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial",
        musculosSecundarios: ["Braquial", "Braquiorradial"],
        equipamento: "Máquina de Polia Baixa com Barra Reta",
        instrucoes: [
            "Fique de frente para a polia baixa, segurando a barra reta com ambas as mãos, pegada supinada (palmas para cima).",
            "Dê um passo para trás para criar tensão no cabo.",
            "Mantenha os cotovelos fixos ao lado do corpo.",
            "Flexione os cotovelos, puxando a barra em direção aos ombros, contraindo o bíceps no topo.",
            "Desça a barra de forma controlada até a extensão quase completa dos braços."
        ],
        observacoes: "Proporciona uma contração isolada e constante no bíceps, similar à rosca direta, mas com a vantagem da polia.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Rosca no Banco Scott com Halteres (Unilateral)",
        grupoMuscular: "Bíceps",
        musculoPrincipal: "Bíceps Braquial",
        musculosSecundarios: ["Braquial"],
        equipamento: "Banco Scott e Halter",
        instrucoes: [
            "Sente-se no banco Scott, ajustando a altura para que a axila fique apoiada no topo do suporte inclinado.",
            "Segure um halter com uma mão, com a palma voltada para cima. O braço deve estar totalmente apoiado no suporte.",
            "Desça o halter lentamente até quase a extensão completa do braço, sentindo o bíceps alongar.",
            "Flexione o cotovelo, trazendo o halter em direção ao ombro, contraindo o bíceps.",
            "Não use impulso. Complete as repetições e troque de lado."
        ],
        observacoes: "Permite um isolamento ainda maior do bíceps, ideal para corrigir assimetrias ou focar intensamente em um lado.",
        gifUrlLocal: nil
    ),

    // --- TRÍCEPS ---
    ExercicioLocal(
        nome: "Tríceps Testa com Barra W",
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
        nome: "Tríceps Pulley com Corda",
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
    // --- Novos exercícios para Tríceps ---
    ExercicioLocal(
        nome: "Tríceps Coice com Halter (Unilateral)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase na cabeça lateral)",
        musculosSecundarios: [],
        equipamento: "Halter e Banco (opcional)",
        instrucoes: [
            "Apoie um joelho e a mão do mesmo lado em um banco plano. Mantenha as costas retas, quase paralelas ao chão.",
            "Segure um halter com a mão livre, com o braço estendido para baixo.",
            "Eleve o cotovelo para que o braço fique paralelo ao tronco e o antebraço aponte para baixo.",
            "Mantendo o cotovelo fixo, estenda o antebraço para trás, empurrando o halter para trás e para cima até o braço ficar completamente reto. Contraia o tríceps no topo.",
            "Retorne o halter lentamente à posição inicial, flexionando o cotovelo. Complete as repetições e troque de lado."
        ],
        observacoes: "Excelente para isolar e dar 'pico' ao tríceps, especialmente a cabeça lateral.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Extensão de Tríceps por Cima da Cabeça com Halter (Duas Mãos)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase na cabeça longa)",
        musculosSecundarios: [],
        equipamento: "Um Halter e Banco (opcional)",
        instrucoes: [
            "Sente-se ou fique em pé, segurando um halter com as duas mãos, uma sobre a outra, com o halter acima da cabeça e os braços estendidos.",
            "Mantenha os cotovelos próximos à cabeça.",
            "Flexione os cotovelos, descendo o halter atrás da cabeça de forma controlada.",
            "Estenda os braços de volta à posição inicial, contraindo o tríceps e focando na cabeça longa."
        ],
        observacoes: "Variante do tríceps francês, que permite usar mais carga com as duas mãos. Ideal para o alongamento da cabeça longa do tríceps.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Tríceps na Máquina (Dips Machine ou Pushdown Machine)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial",
        musculosSecundarios: [],
        equipamento: "Máquina de Tríceps (Dips Machine ou Pushdown Machine)",
        instrucoes: [
            "Ajuste o assento da máquina para que a pegada seja confortável.",
            "Sente-se com as costas apoiadas e os pés firmes no chão.",
            "Segure os pegadores com uma pegada neutra ou pronada (dependendo da máquina).",
            "Empurre os pegadores para baixo até estender completamente os braços, contraindo o tríceps.",
            "Retorne a carga lentamente e controladamente, sentindo o alongamento do tríceps."
        ],
        observacoes: "Oferece um movimento isolado e estável para o tríceps, ideal para focar na contração.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Tríceps com Corda (Polia Alta, Pegada Neutra)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase nas cabeças lateral e medial)",
        musculosSecundarios: [],
        equipamento: "Máquina de Polia Alta com Corda",
        instrucoes: [
            "Fique em pé de frente para a polia alta, segurando a corda com uma pegada neutra (palmas uma para a outra).",
            "Mantenha os cotovelos fixos ao lado do corpo e o tronco levemente inclinado para frente.",
            "Empurre a corda para baixo, estendendo completamente os cotovelos e separando as extremidades da corda no final do movimento para uma contração máxima.",
            "Retorne lentamente à posição inicial, controlando o movimento."
        ],
        observacoes: "A corda permite uma maior amplitude de movimento e ativação das cabeças lateral e medial do tríceps.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Extensão de Tríceps na Polia com Barra V (ou Reta)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial",
        musculosSecundarios: [],
        equipamento: "Máquina de Polia Alta com Barra V ou Reta",
        instrucoes: [
            "Fique em pé de frente para a polia alta, segurando a barra V (ou reta) com pegada pronada ou neutra.",
            "Mantenha os cotovelos fixos ao lado do corpo e o tronco ereto.",
            "Empurre a barra para baixo, estendendo completamente os cotovelos e contraindo o tríceps no final do movimento.",
            "Retorne lentamente à posição inicial, controlando o peso."
        ],
        observacoes: "Exercício fundamental para a massa do tríceps. A barra V pode aliviar a pressão nos punhos para alguns.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Flexões de Braço Diamante (Diamond Push-ups)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial (ênfase na cabeça medial)",
        musculosSecundarios: ["Peitoral Maior (interno)", "Deltoide Anterior"],
        equipamento: "Peso Corporal",
        instrucoes: [
            "Assuma a posição de flexão clássica, mas coloque as mãos juntas no chão formando um diamante com os polegares e indicadores.",
            "Mantenha o corpo reto da cabeça aos calcanhares.",
            "Desça o corpo flexionando os cotovelos, mantendo-os próximos ao corpo, até que o peito quase toque as mãos.",
            "Empurre o corpo de volta à posição inicial, estendendo os braços e focando na contração do tríceps."
        ],
        observacoes: "Uma variação desafiadora da flexão que coloca forte ênfase no tríceps e na porção interna do peitoral. Se for difícil, faça com os joelhos no chão.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Tríceps Banco (Bank Dips)",
        grupoMuscular: "Tríceps",
        musculoPrincipal: "Tríceps Braquial",
        musculosSecundarios: ["Deltoide Anterior", "Peitoral"],
        equipamento: "Banco ou Step",
        instrucoes: [
            "Sente-se na borda de um banco, com as mãos apoiadas ao lado dos quadris, dedos apontando para frente.",
            "Estenda as pernas para a frente (pés no chão para facilitar, ou em outro banco para dificultar).",
            "Deslize os quadris para fora do banco. Flexione os cotovelos, descendo o corpo em direção ao chão até que os braços formem um ângulo de 90 graus.",
            "Mantenha os cotovelos apontando para trás e próximos ao corpo.",
            "Empurre o corpo de volta à posição inicial, estendendo os braços e contraindo o tríceps."
        ],
        observacoes: "Ótimo exercício com peso corporal. Para maior dificuldade, adicione anilhas sobre as coxas.",
        gifUrlLocal: nil
    ),

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
        nome: "Mesa Flexora",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Posterior de coxa",
        musculosSecundarios: ["Panturrilhas", "Glúteos (levemente)"],
        equipamento: "Máquina Flexora Deitada",
        instrucoes: [
            "Deite-se de bruços na máquina, com os joelhos logo abaixo da borda do banco e os tornozelos sob o rolo de apoio.",
            "Segure as manoplas para estabilidade.",
            "Flexione os joelhos, trazendo os calcanhares em direção aos glúteos.",
            "Contraia os isquiotibiais no topo.",
            "Desça o peso lentamente e de forma controlada."
        ],
        observacoes: "Isola bem os posterior (parte traseira da coxa).",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Stiff com Barra (ou Halteres)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Isquiotibiais e Glúteos",
        musculosSecundarios: ["Eretores da Espinha (Lombar)"],
        equipamento: "Barra ou Par de Halteres",
        instrucoes: [
            "Fique em pé com os pés na largura dos ombros, segurando a barra (ou halteres) à frente do corpo com as palmas voltadas para as coxas.",
            "Mantenha os joelhos levemente flexionados durante todo o movimento.",
            "Incline o tronco para frente a partir dos quadris, mantendo as costas retas e a barra próxima às pernas.",
            "Desça a barra até sentir um bom alongamento nos isquiotibiais (geralmente até a altura da canela ou tornozelo).",
            "Retorne à posição inicial, contraindo os glúteos e isquiotibiais, sem usar o impulso da lombar."
        ],
        observacoes: "Foca no alongamento e fortalecimento dos isquiotibiais e glúteos. Mantenha a coluna neutra e evite arredondar as costas.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Afundo com Halteres (Passada)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps, Glúteos",
        musculosSecundarios: ["Posterior de coxa", "Panturrilhas"],
        equipamento: "Par de Halteres",
        instrucoes: [
            "Fique em pé, segurando um halter em cada mão ao lado do corpo.",
            "Dê um passo grande à frente com uma perna, mantendo o tronco ereto.",
            "Abaixe o corpo até que o joelho da perna de trás quase toque o chão e o joelho da frente forme um ângulo de 90 graus (ou próximo a isso).",
            "O joelho da frente não deve ultrapassar a linha dos dedos do pé.",
            "Impulsione-se de volta à posição inicial, retornando a perna que avançou.",
            "Alterne as pernas ou faça todas as repetições de um lado antes de trocar."
        ],
        observacoes: "Melhora a força unilateral e o equilíbrio. Pode ser feito andando (passada) ou no lugar (afundo fixo).",
        gifUrlLocal: nil
    ),
    // --- Novos exercícios para Pernas ---
    ExercicioLocal(
        nome: "Agachamento Búlgaro com Halteres",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps, Glúteos",
        musculosSecundarios: ["Isquiotibiais", "Estabilizadores do Core"],
        equipamento: "Par de Halteres e Banco/Caixa",
        instrucoes: [
            "Fique em pé de costas para um banco ou caixa, a cerca de um passo de distância.",
            "Coloque o peito do pé de uma perna no banco atrás de você. Segure um halter em cada mão ao lado do corpo.",
            "Mantenha o tronco ereto e o core ativado.",
            "Abaixe o corpo flexionando o joelho da perna da frente, como se fosse fazer um agachamento unilateral. O joelho da frente deve formar um ângulo de 90 graus e o joelho de trás deve se aproximar do chão.",
            "Impulsione-se de volta à posição inicial, usando a força da perna da frente. Complete as repetições e troque de lado."
        ],
        observacoes: "Excelente para a força unilateral das pernas e glúteos, além de trabalhar equilíbrio e mobilidade.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Cadeira Flexora",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Isquiotibiais",
        musculosSecundarios: [],
        equipamento: "Máquina Flexora Sentada",
        instrucoes: [
            "Sente-se na máquina com as costas apoiadas e os joelhos alinhados com o eixo de rotação da máquina.",
            "Posicione o apoio dos tornozelos corretamente, logo acima dos calcanhares.",
            "Segure as manoplas laterais para estabilidade.",
            "Flexione os joelhos, puxando os rolos para baixo em direção ao banco, contraindo os isquiotibiais.",
            "Desça o peso lentamente e de forma controlada, sentindo o alongamento."
        ],
        observacoes: "Outra excelente opção para isolar os isquiotibiais, oferecendo uma variação à mesa flexora deitada.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Panturrilha em Pé (Smith ou Máquina de Panturrilha)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Gastrocnêmio (Panturrilha)",
        musculosSecundarios: ["Sóleo"],
        equipamento: "Máquina de Panturrilha em Pé ou Máquina Smith",
        instrucoes: [
            "Posicione os ombros sob as almofadas da máquina (ou a barra Smith) e as pontas dos pés em uma plataforma elevada.",
            "Mantenha os joelhos levemente flexionados (não travados) para proteger as articulações.",
            "Eleve-se o máximo possível nas pontas dos pés, contraindo a panturrilha no topo do movimento.",
            "Desça os calcanhares abaixo da plataforma, sentindo o alongamento na panturrilha.",
            "Execute o movimento de forma controlada, evitando balanços."
        ],
        observacoes: "Foca principalmente no gastrocnêmio. É importante alongar bem na parte inferior do movimento.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Panturrilha Sentado",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Panturrilha",
        musculosSecundarios: [],
        equipamento: "Máquina de Panturrilha Sentada",
        instrucoes: [
            "Sente-se na máquina com os joelhos flexionados a 90 graus e as pontas dos pés na plataforma.",
            "Posicione as almofadas de peso sobre as coxas, logo acima dos joelhos.",
            "Eleve-se o máximo possível nas pontas dos pés, contraindo a panturrilha no topo.",
            "Desça os calcanhares abaixo da plataforma, sentindo o alongamento na panturrilha.",
            "Execute o movimento de forma controlada."
        ],
        observacoes: "Foca mais no sóleo, um músculo da panturrilha que é ativado quando o joelho está flexionado. Ideal para desenvolvimento completo da panturrilha.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Hack Squat (Máquina de Agachamento Hack)",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Quadríceps",
        musculosSecundarios: ["Glúteos", "Isquiotibiais"],
        equipamento: "Máquina Hack Squat",
        instrucoes: [
            "Posicione os ombros sob as almofadas e as costas contra o encosto da máquina.",
            "Coloque os pés na plataforma na largura dos ombros, um pouco à frente (ou mais à frente para mais glúteos/isquiotibiais, ou mais para trás para mais quadríceps).",
            "Destrave a segurança e desça flexionando os joelhos e quadris, mantendo as costas apoiadas, até que as coxas fiquem paralelas à plataforma ou mais baixas.",
            "Empurre de volta à posição inicial, estendendo os joelhos e quadris."
        ],
        observacoes: "Oferece um movimento controlado e seguro, ideal para focar no quadríceps sem a necessidade de estabilizar o tronco como no agachamento livre.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Good Morning com Barra",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Isquiotibiais, Glúteos",
        musculosSecundarios: ["Eretores da Espinha"],
        equipamento: "Barra",
        instrucoes: [
            "Posicione a barra sobre os trapézios (como no agachamento), com os pés na largura dos ombros e joelhos levemente flexionados.",
            "Mantenha as costas retas e o core ativado.",
            "Incline o tronco para frente a partir dos quadris, permitindo que a barra desça à frente do corpo.",
            "Vá até onde conseguir manter a coluna reta e sentir um bom alongamento nos isquiotibiais.",
            "Retorne à posição inicial, contraindo os glúteos e isquiotibiais."
        ],
        observacoes: "Exige boa flexibilidade dos isquiotibiais e força da lombar. Use cargas moderadas para evitar lesões na coluna.",
        gifUrlLocal: nil
    ),
    ExercicioLocal(
        nome: "Elevação Pélvica (Hip Thrust) com Barra",
        grupoMuscular: "Pernas",
        musculoPrincipal: "Glúteos",
        musculosSecundarios: ["Isquiotibiais", "Quadríceps (levemente)"],
        equipamento: "Barra, Anilhas e Banco",
        instrucoes: [
            "Sente-se no chão com as costas apoiadas em um banco (altura do joelho) e a barra posicionada sobre a linha do quadril.",
            "As pernas devem estar flexionadas, com os pés firmes no chão, na largura dos ombros.",
            "Com as mãos na barra (ou usando uma almofada para conforto), levante os quadris em direção ao teto, usando os glúteos para empurrar a barra para cima.",
            "Contraia os glúteos no topo do movimento, formando uma linha reta dos ombros aos joelhos.",
            "Desça os quadris controladamente de volta à posição inicial."
        ],
        observacoes: "Considerado um dos melhores exercícios para desenvolver os glúteos. O foco é na contração máxima dos glúteos no topo do movimento.",
        gifUrlLocal: nil
    )
]
