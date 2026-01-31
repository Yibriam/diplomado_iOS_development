//
//  EntryEditorViewController.swift
//  diaryApp
//
//  Created by You on 30/01/26.
//

import UIKit
import PhotosUI

class EntryEditorViewController: UIViewController {
    private let viewModel = EntryEditorViewModel()

    private var editingEntry: DiaryEntry?

    private var selectedLocation: Location?

    // MARK: - UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Entry Title"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let messageTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemGray4.cgColor
        tv.layer.cornerRadius = 8
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()

    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.layer.cornerRadius = 8
        iv.isHidden = true
        return iv
    }()

    private let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Photo", for: .normal)
        return btn
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "No location selected"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let selectLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Select Location", for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.cornerRadius = 8
        return btn
    }()

    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save Entry", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }()

    // MARK: - Init
    init(entry: DiaryEntry?) {
        self.editingEntry = entry
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        setupActions()
        setupDraftObserver()
        populateIfEditing()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [titleTextField, messageTextView, photoImageView, selectPhotoButton, locationLabel, selectLocationButton, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            messageTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            messageTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            messageTextView.heightAnchor.constraint(equalToConstant: 200),

            photoImageView.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 200),
            photoImageView.heightAnchor.constraint(equalToConstant: 200),

            selectPhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            selectPhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            locationLabel.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            selectLocationButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            selectLocationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            saveButton.topAnchor.constraint(equalTo: selectLocationButton.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Actions
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        selectPhotoButton.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        selectLocationButton.addTarget(self, action: #selector(didTapLocation), for: .touchUpInside)

        // also add a camera button in nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                                            target: self,
                                                            action: #selector(didTapPhoto))
    }

    @objc private func didTapPhoto() {
        let actionSheet = UIAlertController(title: "Add Photo", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in self.showCamera() })
        actionSheet.addAction(UIAlertAction(title: "Choose from Gallery", style: .default) { _ in self.showGallery() })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }

    @objc private func didTapLocation() {
        let locationVC = LocationSearchViewController()
        locationVC.delegate = self
        let nav = UINavigationController(rootViewController: locationVC)
        present(nav, animated: true)
    }

    @objc private func didTapSave() {
        viewModel.saveEntry(
            title: titleTextField.text ?? "",
            message: messageTextView.text,
            image: photoImageView.image,
            location: selectedLocation,
            isDraft: false,
            existingId: editingEntry?.id
        )
        navigationController?.popViewController(animated: true)
    }


    private func setupDraftObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveDraftAndExit),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }

    @objc private func saveDraftAndExit() {
        viewModel.saveAsDraft(
            title: titleTextField.text ?? "",
            message: messageTextView.text,
            image: photoImageView.image,
            location: selectedLocation,
            existingId: editingEntry?.id
        )
        navigationController?.popToRootViewController(animated: false)
    }


    // MARK: - Populate editing entry
    private func populateIfEditing() {
        guard let entry = editingEntry else { return }
        titleTextField.text = entry.title
        messageTextView.text = entry.message
        selectedLocation = entry.location
        if let loc = entry.location {
            locationLabel.text = loc.address
            locationLabel.textColor = .label
        }
        if let photoFilename = entry.photoFilename {
            if let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let url = documents.appendingPathComponent(photoFilename)
                if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                    photoImageView.image = img
                    photoImageView.isHidden = false
                }
            }
        }
    }
}

// MARK: - LocationSearchDelegate
extension EntryEditorViewController: LocationSearchDelegate {
    func didSelectLocation(_ location: Location) {
        selectedLocation = location
        locationLabel.text = location.address
        locationLabel.textColor = .label
    }
}

// MARK: - Photo pickers
extension EntryEditorViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showGallery() {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider else { return }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                DispatchQueue.main.async {
                    guard let self = self, let image = object as? UIImage else { return }
                    self.photoImageView.image = image
                    self.photoImageView.isHidden = false
                }
            }
        }
    }

    func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            photoImageView.image = image
            photoImageView.isHidden = false
        }
    }
}
