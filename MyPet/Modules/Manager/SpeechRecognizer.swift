//
//  SpeechRecognizer.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 12.03.25.
//

import Foundation
import Speech
import AVFoundation

class SpeechRecognizer: NSObject {
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    var onResult: ((String) -> Void)?

    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }

    func requestPermissions(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Speech recognition permission granted")
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    print(granted ? "Microphone permission granted" : "Microphone permission denied")
                    completion(granted)
                }
            default:
                print("Speech recognition permission denied")
                completion(false)
            }
        }
    }

    func startListening() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Recognizer is not available")
            return
        }

        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            request = SFSpeechAudioBufferRecognitionRequest()
            guard let request = request else { return }
            request.shouldReportPartialResults = true

            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                request.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()

            recognitionTask = recognizer.recognitionTask(with: request) { result, error in
                if let result = result {
                    let recognizedText = result.bestTranscription.formattedString
                    self.onResult?(recognizedText)
                }
                if error != nil || (result?.isFinal ?? false) {
                    self.stopListening()
                }
            }

            print("Starting recording")
        } catch {
            print("Eror: \(error.localizedDescription)")
        }
    }

    func stopListening() {
        guard recognitionTask != nil else { return }
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
        print("Record ended")
    }
}

// MARK: - SFSpeechRecognizerDelegate
extension SpeechRecognizer: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print(available ? "Recognition is available" : "Recognizer is not available")
    }
}
