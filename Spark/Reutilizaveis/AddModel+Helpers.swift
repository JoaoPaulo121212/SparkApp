import SwiftUI

extension AddModel {
    func formatarData(_ data: Date) -> String {
        let formatter = DateFormatter(); formatter.dateStyle = .medium; formatter.timeStyle = .none
        return formatter.string(from: data)
    }
    
    func gerarNomeSessaoPlaceholderCalculado() -> String {
        let proximoIndice = gerenciadorSessoes.sessoesDeTreinoSalvas.count
        if idSessaoEditando == nil && proximoIndice < gerenciadorSessoes.limiteMaximoSessoes {
            if proximoIndice < 26 {
                 let letra = String(UnicodeScalar("A".unicodeScalars.first!.value + UInt32(proximoIndice))!)
                 return "Treino \(letra)"
            } else { return "Treino \(proximoIndice + 1)" }
        }
        return "Nova Sessão"
    }
    
    func textoPlaceholderNomeSessao() -> String {
        if idSessaoEditando == nil {
            if nomeSessaoAtual.isEmpty && !nomeSessaoInteragido {
                return gerarNomeSessaoPlaceholderCalculado()
            } else if nomeSessaoAtual.isEmpty && nomeSessaoInteragido {
                return "Nome da sessão"
            }
            if nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoInteragido {
                return nomeSessaoAtual
            }
            return "Nome da sessão"
        }
        return "Nome da sessão"
    }
    
    func tituloDaToolbar() -> String {
        if modoCriacaoEdicaoAtivo {
            if idSessaoEditando == nil {
                if nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoInteragido {
                    return "Nova Sessão"
                }
                return nomeSessaoAtual.isEmpty ? "Nova Sessão" : nomeSessaoAtual
            } else {
                return "Editar: \(nomeSessaoAtual.isEmpty ? "Sessão" : nomeSessaoAtual)"
            }
        } else {
            return "Minhas Sessões"
        }
    }
}
