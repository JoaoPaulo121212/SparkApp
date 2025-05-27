import Foundation
enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case custom(description: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida."
        case .requestFailed(let error):
            return "Falha na requisição: \(error.localizedDescription)"
        case .invalidResponse:
            return "Resposta inválida do servidor."
        case .decodingError(let error):
            return "Falha ao decodificar os dados: \(error.localizedDescription)."
        case .custom(let description):
            return description
        }
    }
}
class ExerciseAPIService {
    private let apiKey = "2eba42c022msh5de8d33b65f74c6p1da0d9jsn0f1f160bb40d"
    private let apiHost = "exercise-db-fitness-workout-gym.p.rapidapi.com"
    private let baseURL = "https://exercisedb.p.rapidapi.com"
    
    func fetchAllExerciseIDs() async throws -> [String] {
        guard !apiKey.isEmpty else {
            throw APIError.custom(description: "Chave de API não configurada corretamente.")
        }

        guard let url = URL(string: "\(baseURL)/exercises") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? "Sem dados no corpo da resposta."
            throw APIError.custom(description: "Erro HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode)): \(body.prefix(200))")
        }

        // DEBUG: mostrar a resposta da API
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🚀 JSON da API:\n\(jsonString.prefix(1000))\n") // Mostra só os primeiros 1000 caracteres
        }

        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(ExerciseIDListResponse.self, from: data)
            return decoded.idsDosExercicios
        } catch let decodingError as DecodingError {
            print("❌ Erro ao decodificar: \(decodingError.localizedDescription)")
            throw APIError.decodingError(decodingError)
        } catch {
            throw APIError.requestFailed(error)
        }
    }


    func fetchExerciseDetails(id: String) async throws -> ExercicioDetalhado {
        guard !apiKey.isEmpty, apiKey != "chavePlaceholder" else {
             throw APIError.custom(description: "Chave de API não configurada corretamente.")
        }

        guard let url = URL(string: "\(baseURL)/exercise/\(id)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorPayload = String(data: data, encoding: .utf8) ?? "Nenhuma mensagem de erro adicional."
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                throw APIError.custom(description: "Erro do servidor ao buscar detalhes do ID '\(id)': Status \(statusCode). Detalhes: \(errorPayload.prefix(200))")
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode(ExercicioDetalhado.self, from: data)
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let type, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Detalhes ID: \(id)): TypeMismatch - Expected type '\(type)' at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .valueNotFound(let type, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Detalhes ID: \(id)): ValueNotFound - No value found for type '\(type)' at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .keyNotFound(let key, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Detalhes ID: \(id)): KeyNotFound - Key '\(key.stringValue)' not found at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .dataCorrupted(let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Detalhes ID: \(id)): DataCorrupted - Data is corrupted at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            @unknown default:
                print("--> DecodingError (Detalhes ID: \(id)): An unknown decoding error occurred.")
            }
            throw APIError.decodingError(error)
        } catch {
            if error is APIError { throw error }
            throw APIError.requestFailed(error)
        }
    }
    
    func fetchExercises(byMuscle muscle: String) async throws -> [ExercicioDetalhado] {
        guard !apiKey.isEmpty, apiKey != "chavePlaceholder" else {
            throw APIError.custom(description: "Chave de API não configurada corretamente.")
        }

        let formattedMuscle = muscle.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let url = URL(string: "\(baseURL)/exercises/muscle/\(formattedMuscle)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorPayload = String(data: data, encoding: .utf8) ?? "Nenhuma mensagem de erro adicional."
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                throw APIError.custom(description: "Erro do servidor ao buscar exercícios por músculo: Status \(statusCode). Detalhes: \(errorPayload.prefix(200))")
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode([ExercicioDetalhado].self, from: data)
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let type, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Músculo: \(formattedMuscle)): TypeMismatch - Expected type '\(type)' at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .valueNotFound(let type, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Músculo: \(formattedMuscle)): ValueNotFound - No value found for type '\(type)' at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .keyNotFound(let key, let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Músculo: \(formattedMuscle)): KeyNotFound - Key '\(key.stringValue)' not found at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            case .dataCorrupted(let context):
                var path = context.codingPath.map { $0.stringValue }.joined(separator: ".")
                path = path.isEmpty ? "root" : path
                print("--> DecodingError (Músculo: \(formattedMuscle)): DataCorrupted - Data is corrupted at path '\(path)'.")
                if let underlying = context.underlyingError { print("    Underlying error: \(underlying)") }
            @unknown default:
                print("--> DecodingError (Músculo: \(formattedMuscle)): An unknown decoding error occurred.")
            }
            throw APIError.decodingError(error)
        } catch {
            if error is APIError { throw error }
            throw APIError.requestFailed(error)
        }
    }
}
