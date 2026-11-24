# Defesa de Arquitetura de Software — Pull Request

## Nicolas Romanichen
- *Igor Aguiar* 
- *Artefato(s) de Responsabilidade:* Diagrama de Sequência e ADR 0001]

## O que este PR introduz na Documentação Viva?
Descreva sucintamente as alterações e os novos modelos adicionados à pasta /docs/:
- [ ] *Visão Funcional / Estrutural:* Diagrama de Casos de Uso ou Diagrama de Classes e Interfaces.
- [X] *Visão Comportamental:* Diagrama de Sequência, Atividades (com Raias/Fork-Join) ou Máquina de Estados.
- [X] *Visão Arquitetural Macro:* Modelo C4 (L1, L2 ou L3 em Structurizr DSL).
- [ ] *Governança:* Registros de Decisão Arquitetural (ADR).

## Defesa das Decisões de Design (Justificativa Técnica)
1. Escolha de Abstrações e Desacoplamento
O Pipeline RAG foi dividido em elementos com responsabilidades específicas, separando o processamento de linguagem natural, a recuperação de informações, o armazenamento de regras aduaneiras e a formatação das respostas. Essa separação favorece a manutenibilidade e o desacoplamento, permitindo que os serviços sejam modificados com menor impacto sobre os demais elementos do sistema. A separação entre o índice vetorial e o repositório documental também permite distinguir a busca semântica do armazenamento das informações normativas originais.

2. Dinâmica e Resiliência
As interações foram numeradas para representar a ordem de execução do Pipeline RAG, garantindo a compreensão do fluxo de informações entre os elementos. A recuperação do contexto antes da chamada ao modelo de inteligência artificial busca reduzir a geração de informações incorretas e fundamentar as respostas em fontes normativas.
O diagrama representa o fluxo principal de execução, não contemplando explicitamente fluxos alternativos, indisponibilidade de serviços, ausência de resultados relevantes ou tratamento de falhas.

3. Trade-offs
A utilização do RAG favorece a contextualização, a atualização das informações e a rastreabilidade das fontes utilizadas na elaboração das respostas, sem exigir o retreinamento do modelo de inteligência artificial a cada atualização normativa. Em contrapartida, essa abordagem aumenta a complexidade arquitetural, a latência das consultas e a dependência da disponibilidade dos serviços de recuperação e geração de respostas.

## Consistência Cross-Diagramas (Checklist de Autoverificação)
Antes de solicitar a revisão de um colega, confirme o alinhamento entre os modelos:
- [X] Os nomes de métodos chamados no Diagrama de Sequência existem nas interfaces do Diagrama de Classes.
- [X] Os contêineres e componentes citados correspondem exatamente à nomenclatura do Modelo C4 L2/L3.
- [X] As transições de estado refletem os gatilhos disparados pelas atividades da aplicação.

## Validação da Sintaxe Diagrams-as-Code / Models-as-Code
- *Ferramenta de Compilação/Renderização Utilizada: Structurizr CLI* 
- *Status da Compilação:* [X] Código limpo e sem erros de sintaxe ao renderizar.
