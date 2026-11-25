workspace "Assistente de IA para Exportação" "Diagrama dinâmico do Pipeline RAG" {
    model {
        usuario = person "Usuário" "Consulta regras e requisitos de exportação."
        llm = softwareSystem "Modelo de Inteligência Artificial" "Gera orientações com base na pergunta e no contexto recuperado."

        assistente = softwareSystem "Assistente de IA para Exportação" {
            interfaceSistema = container "Interface do Sistema" "Recebe consultas e apresenta respostas." "Aplicação Web"
            processador = container "Processador de Linguagem Natural" "Interpreta a pergunta e coordena o processamento da consulta." "Serviço de processamento"
            rag = container "Serviço de Recuperação RAG" "Gera o embedding da consulta, coordena a busca semântica e recupera contexto relevante." "Serviço de recuperação"
            indice = container "Índice Vetorial" "Armazena embeddings e referências para busca semântica." "Banco vetorial"
            repositorio = container "Repositório de Regras Aduaneiras" "Armazena regras, documentos, fontes oficiais, metadados e vigência." "Repositório documental"
        }

        usuario -> interfaceSistema "Solicita orientação sobre exportação" "HTTPS"
        interfaceSistema -> processador "Envia pergunta e contexto"
        processador -> rag "Solicita recuperação de contexto relevante"
        rag -> indice "Pesquisa vetores semanticamente semelhantes"
        indice -> rag "Retorna referências relevantes"
        rag -> repositorio "Consulta trechos e fontes normativas"
        repositorio -> rag "Retorna trechos, fontes, metadados e vigência"
        rag -> processador "Retorna contexto recuperado e referências"
        processador -> llm "Envia pergunta e contexto recuperado"
        llm -> processador "Retorna resposta gerada"
        processador -> interfaceSistema "Retorna resposta estruturada com fontes e ressalvas"
        interfaceSistema -> usuario "Exibe orientação final" "HTTPS"
    }

    views {
        dynamic assistente "PipelineRAG" "Fluxo principal de consulta e geração de resposta com RAG." {
            title "Diagrama Dinâmico C4 — Pipeline RAG"
            usuario -> interfaceSistema "Solicita orientação sobre exportação"
            interfaceSistema -> processador "Envia pergunta e contexto"
            processador -> rag "Solicita recuperação de contexto relevante"
            rag -> indice "Gera embedding da consulta e pesquisa vetores semelhantes"
            indice -> rag "Retorna referências relevantes"
            rag -> repositorio "Consulta trechos e fontes pelas referências"
            repositorio -> rag "Retorna trechos, fontes, metadados e vigência"
            rag -> processador "Retorna contexto recuperado e referências"
            processador -> llm "Envia pergunta e contexto recuperado"
            llm -> processador "Retorna resposta gerada"
            processador -> interfaceSistema "Formata e retorna resposta com fontes e ressalvas"
            interfaceSistema -> usuario "Exibe orientação final"
            autoLayout lr 350 250
        }

        styles {
            element "Element" {
                shape Box
                background #ffffff
                color #222222
                stroke #555555
                fontSize 24
            }
            relationship "Relationship" {
                color #555555
                dashed true
                fontSize 22
                thickness 2
            }
        }
    }
}
