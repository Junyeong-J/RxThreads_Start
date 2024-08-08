//
//  BoxOfficeTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/8/24.
//

import UIKit
import SnapKit

final class BoxOfficeTableViewCell: BaseTableViewCell {
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(releaseDateLabel)
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(rankLabel)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(8)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(rankLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configureData(data: DailyBoxOfficeList, index: Int) {
        rankLabel.text = "\(index)"
        movieTitleLabel.text = data.movieNm
        releaseDateLabel.text = data.openDt
    }
    
}
