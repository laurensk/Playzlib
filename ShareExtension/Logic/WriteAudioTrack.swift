//
//  WriteAudioTrack.swift
//  ShareExtension
//
//  Created by Laurens on 27.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import AVFoundation
extension AVAsset {

    func writeAudioTrackToURL(_ url: URL, completion: @escaping (Bool, Error?) -> ()) {
        do {
            let audioAsset = try self.audioAsset()
            audioAsset.writeToURL(url, completion: completion)
        } catch (let error as NSError){
            completion(false, error)
        }
    }

    func writeToURL(_ url: URL, completion: @escaping (Bool, Error?) -> ()) {

        guard let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetAppleM4A) else {
            completion(false, nil)
            return
        }

        exportSession.outputFileType = .m4a
        exportSession.outputURL      = url

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(true, nil)
            case .unknown, .waiting, .exporting, .failed, .cancelled:
                completion(false, nil)
            default:
                completion(false, nil)
            }
        }
    }

    func audioAsset() throws -> AVAsset {

        let composition = AVMutableComposition()
        let audioTracks = tracks(withMediaType: .audio)

        for track in audioTracks {

            let compositionTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
            try compositionTrack?.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
            compositionTrack?.preferredTransform = track.preferredTransform
        }
        return composition
    }
}
