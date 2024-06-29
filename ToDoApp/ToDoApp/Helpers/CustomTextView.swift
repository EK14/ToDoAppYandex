//  Created by Elina Karapetian on 25.06.2024.

import SwiftUI

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    var placeholder: String

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.textColor = C.labelPrimary.color
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.isScrollEnabled = true
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.delegate = context.coordinator
        textView.textContainerInset = Constants.textViewTextContainerInset
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
        textView.textContainer.lineFragmentPadding = .zero
        return textView
    }

    func updateUIView(_ textView: UIViewType, context _: Context) {
        textView.text = text
    }

    func makeCoordinator() -> TextViewCoordinator {
        TextViewCoordinator(text: $text, height: $height, placeholder: placeholder)
    }
}

class TextViewCoordinator: NSObject, UITextViewDelegate {
    @Binding var text: String
    var placeholder: String
    @Binding var height: CGFloat

    init(text: Binding<String>, height: Binding<CGFloat>, placeholder: String) {
        _text = text
        _height = height
        self.placeholder = placeholder
    }

    func textViewDidChange(_ textView: UITextView) {
        $text.wrappedValue = textView.text == placeholder ? "" : textView.text

        let size = CGSize(width: Constants.textViewTextWidth, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)

        textView.isScrollEnabled = false
        for constraints in textView.constraints {
            if constraints.firstAttribute == .height {
                constraints.constant = estimatedSize.height
                height = max(estimatedSize.height, Constants.textViewDefaultHeight)
            }
        }
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == UIColor.tertiaryLabel {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
}
