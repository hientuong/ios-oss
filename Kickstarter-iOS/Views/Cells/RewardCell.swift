import KsApi
import Library
import Prelude

internal final class RewardCell: UITableViewCell, ValueCell {
  private let viewModel: RewardCellViewModelType = RewardCellViewModel()

  @IBOutlet private weak var allGoneContainerView: UIView!
  @IBOutlet private weak var allGoneLabel: UILabel!
  @IBOutlet private weak var backersCountLabel: UILabel!
  @IBOutlet private var bulletSeparatorViews: [UILabel]!
  @IBOutlet private weak var cardView: UIView!
  @IBOutlet private weak var checkmarkImageView: UIImageView!
  @IBOutlet private weak var conversionLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var footerStackView: UIStackView!
  @IBOutlet private weak var includesTitleLabel: UILabel!
  @IBOutlet private weak var itemsContainerStackView: UIStackView!
  @IBOutlet private weak var itemsHeaderStackView: UIStackView!
  @IBOutlet private weak var itemsStackView: UIStackView!
  @IBOutlet private weak var manageRewardButton: UIButton!
  @IBOutlet private weak var minimumLabel: UILabel!
  @IBOutlet private weak var minimumStackView: UIStackView!
  @IBOutlet private weak var remainingLabel: UILabel!
  @IBOutlet private weak var remainingStackView: UIStackView!
  @IBOutlet private weak var rewardTitleLabel: UILabel!
  @IBOutlet private weak var rootStackView: UIStackView!
  @IBOutlet private weak var selectRewardButton: UIButton!
  @IBOutlet private var separatorViews: [UIView]!
  @IBOutlet private weak var statsStackView: UIStackView!
  @IBOutlet private weak var titleDescriptionStackView: UIStackView!
  @IBOutlet private weak var viewYourPledgeButton: UIButton!
  @IBOutlet private weak var youreABackerCheckmarkImageView: UIImageView!
  @IBOutlet private weak var youreABackerContainerView: UIView!
  @IBOutlet private weak var youreABackerLabel: UILabel!
  @IBOutlet private weak var youreABackerStackView: UIStackView!

  func configureWith(value value: (Project, Reward)) {
    self.viewModel.inputs.configureWith(project: value.0, reward: value.1)
  }

  // swiftlint:disable function_body_length
  internal override func bindStyles() {
    super.bindStyles()

    self
      |> baseTableViewCellStyle()
      |> (UITableViewCell.lens.contentView • UIView.lens.layoutMargins) .~
        .init(top: Styles.grid(1), left: Styles.grid(2), bottom: Styles.grid(2), right: Styles.grid(2))

    self.rootStackView
      |> UIStackView.lens.spacing .~ Styles.grid(4)
      |> UIStackView.lens.layoutMargins
        .~ .init(top: Styles.grid(3), left: Styles.grid(4), bottom: Styles.grid(2), right: Styles.grid(4))
      |> UIStackView.lens.layoutMarginsRelativeArrangement .~ true

    self.minimumStackView
      |> UIStackView.lens.spacing .~ Styles.grid(1)

    self.titleDescriptionStackView
      |> UIStackView.lens.spacing .~ Styles.grid(2)

    [self.itemsContainerStackView, self.itemsHeaderStackView, self.itemsStackView]
      ||> UIStackView.lens.spacing .~ Styles.grid(2)

    self.footerStackView
      |> UIStackView.lens.spacing .~ Styles.grid(2)

    self.statsStackView
      |> UIStackView.lens.spacing .~ Styles.gridHalf(1)

    self.allGoneContainerView
      |> roundedStyle(cornerRadius: 2)
      |> UIView.lens.backgroundColor .~ UIColor.ksr_navy_700
      |> UIView.lens.layoutMargins .~ .init(topBottom: Styles.gridHalf(1), leftRight: Styles.grid(1))

    self.allGoneLabel
      |> UILabel.lens.textColor .~ .whiteColor()
      |> UILabel.lens.font .~ .ksr_headline(size: 12)
      |> UILabel.lens.text %~ { _ in Strings.All_gone() }

    self.cardView
      |> dropShadowStyle()

    self.minimumLabel
      |> UILabel.lens.font .~ .ksr_title2(size: 24)

    self.conversionLabel
      |> UILabel.lens.font .~ UIFont.ksr_caption1().italicized

    self.rewardTitleLabel
      |> UILabel.lens.font .~ .ksr_body(size: 18)
      |> UILabel.lens.numberOfLines .~ 0

    self.descriptionLabel
      |> UILabel.lens.font .~ .ksr_body(size: 16)
      |> UILabel.lens.textColor .~ .ksr_text_navy_500
      |> UILabel.lens.numberOfLines .~ 0

    self.includesTitleLabel
      |> UILabel.lens.font .~ .ksr_headline(size: 13)
      |> UILabel.lens.textColor .~ .ksr_text_navy_700
      |> UILabel.lens.text %~ { _ in Strings.rewards_info_includes() }

    self.youreABackerCheckmarkImageView
      |> UIImageView.lens.tintColor .~ .ksr_text_navy_700
      |> UIImageView.lens.image %~ { _ in
        UIImage(named: "checkmark-icon", inBundle: .framework, compatibleWithTraitCollection: nil)
    }

    self.youreABackerContainerView
      |> roundedStyle(cornerRadius: 2)
      |> UIView.lens.backgroundColor .~ UIColor.ksr_green_700
      |> UIView.lens.layoutMargins .~ .init(all: Styles.grid(1))

    self.youreABackerLabel
      |> UILabel.lens.font .~ .ksr_headline(size: Styles.grid(2))
      |> UILabel.lens.textColor .~ .whiteColor()
      |> UILabel.lens.text %~ { _ in Strings.Youre_a_backer() }

    self.youreABackerStackView
      |> UIStackView.lens.layoutMargins .~ self.allGoneContainerView.layoutMargins
      |> UIStackView.lens.layoutMarginsRelativeArrangement .~ true
      |> UIStackView.lens.spacing .~ Styles.gridHalf(1)
      |> UIStackView.lens.alignment .~ .Center

    self.checkmarkImageView
      |> UIImageView.lens.tintColor .~ .whiteColor()

    self.remainingLabel
      |> UILabel.lens.font .~ .ksr_caption1()
      |> UILabel.lens.textColor .~ .ksr_text_navy_500

    self.remainingStackView
      |> UIStackView.lens.alignment .~ .Center
      |> UIStackView.lens.spacing .~ self.statsStackView.spacing

    self.backersCountLabel
      |> UILabel.lens.font .~ .ksr_caption1()
      |> UILabel.lens.textColor .~ .ksr_text_navy_500

    self.separatorViews
      ||> separatorStyle

    self.bulletSeparatorViews
      ||> UILabel.lens.textColor .~ .ksr_text_navy_500

    self.selectRewardButton
      |> greenButtonStyle
      |> UIButton.lens.userInteractionEnabled .~ false

    self.manageRewardButton
      |> borderButtonStyle
      |> UIButton.lens.userInteractionEnabled .~ false
      |> UIButton.lens.title(forState: .Normal) %~ { _ in Strings.Manage_your_reward() }

    self.viewYourPledgeButton
      |> borderButtonStyle
      |> UIButton.lens.userInteractionEnabled .~ false
      |> UIButton.lens.title(forState: .Normal) %~ { _ in Strings.project_view_button() }

    self.viewModel.inputs.boundStyles()
  }
  // swiftlint:enable function_body_length

  internal override func bindViewModel() {
    super.bindViewModel()

    self.allGoneContainerView.rac.hidden = self.viewModel.outputs.allGoneHidden
    self.backersCountLabel.rac.text = self.viewModel.outputs.backersCountLabelText
    self.cardView.rac.backgroundColor = self.viewModel.outputs.cardViewBackgroundColor
    self.contentView.rac.backgroundColor = self.viewModel.outputs.contentViewBackgroundColor
    self.conversionLabel.rac.hidden = self.viewModel.outputs.conversionLabelHidden
    self.conversionLabel.rac.text = self.viewModel.outputs.conversionLabelText
    self.conversionLabel.rac.textColor = self.viewModel.outputs.minimumAndConversionLabelsColor
    self.descriptionLabel.rac.hidden = self.viewModel.outputs.descriptionLabelHidden
    self.descriptionLabel.rac.text = self.viewModel.outputs.descriptionLabelText
    self.footerStackView.rac.alignment = self.viewModel.outputs.footerStackViewAlignment
    self.footerStackView.rac.axis = self.viewModel.outputs.footerStackViewAxis
    self.footerStackView.rac.hidden = self.viewModel.outputs.footerStackViewHidden
    self.itemsContainerStackView.rac.hidden = self.viewModel.outputs.itemsContainerHidden
    self.manageRewardButton.rac.hidden = self.viewModel.outputs.manageButtonHidden
    self.minimumLabel.rac.text = self.viewModel.outputs.minimumLabelText
    self.minimumLabel.rac.textColor = self.viewModel.outputs.minimumAndConversionLabelsColor
    self.remainingLabel.rac.text = self.viewModel.outputs.remainingLabelText
    self.remainingStackView.rac.hidden = self.viewModel.outputs.remainingStackViewHidden
    self.rewardTitleLabel.rac.hidden = self.viewModel.outputs.titleLabelHidden
    self.rewardTitleLabel.rac.text = self.viewModel.outputs.titleLabelText
    self.rewardTitleLabel.rac.textColor = self.viewModel.outputs.titleLabelTextColor
    self.selectRewardButton.rac.hidden = self.viewModel.outputs.pledgeButtonHidden
    self.selectRewardButton.rac.title = self.viewModel.outputs.pledgeButtonTitleText
    self.viewYourPledgeButton.rac.hidden = self.viewModel.outputs.viewPledgeButtonHidden
    self.youreABackerContainerView.rac.hidden = self.viewModel.outputs.youreABackerViewHidden

    self.viewModel.outputs.cardViewDropShadowHidden
      .observeForUI()
      .observeNext { [weak self] hidden in
        self?.cardView.layer.shadowOpacity = hidden ? 0 : 1
    }

    self.viewModel.outputs.updateTopMarginsForIsBacking
      .observeForUI()
      .observeNext { [weak self] isBacking in
        self?.contentView.layoutMargins.top = Styles.grid(isBacking ? 3 : 1)
    }

    self.viewModel.outputs.items
      .observeForUI()
      .observeNext { [weak self] in self?.load(items: $0) }
  }

  private func load(items items: [String]) {
    self.itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    for item in items {
      let label = UILabel()
        |> UILabel.lens.font .~ .ksr_body(size: 14)
        |> UILabel.lens.textColor .~ .ksr_text_navy_600
        |> UILabel.lens.text .~ item
        |> UILabel.lens.numberOfLines .~ 0

      let separator = UIView()
        |> separatorStyle
      separator.heightAnchor.constraintEqualToConstant(1).active = true

      self.itemsStackView.addArrangedSubview(label)
      self.itemsStackView.addArrangedSubview(separator)
    }
  }
}