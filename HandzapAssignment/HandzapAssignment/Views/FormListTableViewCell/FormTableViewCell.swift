//
//  AddFormViewModel.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

protocol FormTableViewCellDelegate: class {
    func didTapOnOptionBtn(cell: FormTableViewCell?)
}
class FormTableViewCell: UITableViewCell {
    
    //IBOutlet
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewCountBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var jobTermBtn: UIButton!
    @IBOutlet weak var optionBtn: UIButton!
    //Delegate
    weak var delegate: FormTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.baseView.layer.borderWidth = 0.5
        self.baseView.layer.borderColor = AppColor.color(.lineColor).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //IBACtion
    @IBAction func onTapOptionBtn(_ sender: UIButton) {
        self.delegate?.didTapOnOptionBtn(cell: self)
    }

    //Configure
    func configureFor(form: Form?) {
        let noData = "No data"
        titleLabel.text = form?.title ?? noData
        dateLabel.text = form?.startDate ?? noData
        viewCountBtn.setTitle("144 Views", for: .normal)
        rateBtn.setTitle(form?.rate ?? noData, for: .normal)
        jobTermBtn.setTitle(form?.jobTerms ?? noData, for: .normal)
    }
}


