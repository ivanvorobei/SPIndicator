// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import SparrowKit
import SPDiffable
import SPIndicator

class PresetsController: SPDiffableTableController {
    
    // MARK: - Init
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SPIndicator Presets"
        
        currentPreset = presets.first!
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        
        let segmentedControl = UISegmentedControl(items: ["Top", "Center", "Bottom"])
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        
        navigationController?.isToolbarHidden = false
        toolbarItems = [
            .init(image: .system("chevron.down.circle"), primaryAction: .init(handler: { (action) in
                guard let currentPreset = self.currentPreset else {
                    self.currentPreset = self.presets.first
                    return
                }
                guard let index = self.presets.firstIndex(where: { $0.id == currentPreset.id }) else { return }
                self.currentPreset = self.presets[safe: index + 1]
                if self.currentPreset == nil {
                    self.currentPreset = self.presets.first
                }
            })),
            .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            .init(systemItem: .play, primaryAction: .init(handler: { [weak self] (action) in
                guard let self = self else { return }
                guard let preset = self.currentPreset else { return }
                guard let segmentControl = self.navigationItem.titleView as? UISegmentedControl else { return }
                
                let presentSide: SPIndicatorPresentSide = {
                    switch segmentControl.selectedSegmentIndex {
                    case 0: return SPIndicatorPresentSide.top
                    case 1: return SPIndicatorPresentSide.center
                    case 2: return SPIndicatorPresentSide.bottom
                    default: fatalError()
                    }
                }()
                
                if let iconPreset = preset.preset {
                    SPIndicator.present(title: preset.title, message: preset.message, preset: iconPreset, from: presentSide, completion: nil)
                } else {
                    SPIndicator.present(title: preset.title, message: preset.message, haptic: .success, from: presentSide)
                }
                
            }), menu: nil),
            .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        ]
    }
    
    // MARK: - Data
    
    fileprivate var presets: [IndicatorPresetModel] {
        return [
            IndicatorPresetModel(
                name: "Done",
                title: "Done",
                message: "Animatable",
                preset: .done
            ),
            IndicatorPresetModel(
                name: "Error",
                title: "Oops",
                message: "Try again",
                preset: .error
            ),
            IndicatorPresetModel(
                name: "Custom Image",
                title: "Custom Image",
                message: "SFSymbols Image",
                preset: .custom(UIImage.init(systemName: "swift")!)
            ),
            IndicatorPresetModel(
                name: "Specific Tint",
                title: "Specific Tint",
                message: "For any image",
                preset: .custom(UIImage.init(systemName: "sun.min.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
            ),
            IndicatorPresetModel(
                name: "Message",
                title: "Only Title",
                message: nil,
                preset: nil
            ),
            IndicatorPresetModel(
                name: "Message with Subtitle",
                title: "Title",
                message: "Subtitle",
                preset: nil
            ),
            IndicatorPresetModel(
                name: "Message Large Text with Icon",
                title: "You can read it later when you have time.",
                message: nil,
                preset: .custom(UIImage.init(systemName: "envelope.open.fill")!)
            ),
            IndicatorPresetModel(
                name: "Message Large Text without Icon",
                title: "You can read it later when you have time. Saved to Bookmarks",
                message: nil,
                preset: nil
            )
        ]
    }
    
    // MARK: - Diffable
    
    var currentPreset: IndicatorPresetModel? {
        didSet {
            diffableDataSource?.set(self.content, animated: true, completion: nil)
        }
    }
    
    var content: [SPDiffableSection] {
        let items = presets.map { (preset) -> SPDiffableTableRow in
            return SPDiffableTableRow(
                text: preset.name,
                accessoryType: (preset.id == currentPreset?.id) ? .checkmark : .none,
                selectionStyle: .none) { [weak self] _, _ in
                guard let self = self else { return }
                self.currentPreset = preset
            }
        }
        return [
            SPDiffableSection(id: "presets", header: nil, footer: nil, items: items)
        ]
    }
}
