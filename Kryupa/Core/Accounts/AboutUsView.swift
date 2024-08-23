//
//  AboutUsView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct AboutUsView: View {
    @State var arrAboutUs: [AboutUsData] = [
        AboutUsData(title: "Welcome to Kryupa,", desc: "where care meets compassion. Our platform is dedicated to connecting individuals who need care with trusted caregivers, making the process seamless and reliable for everyone involved."),
        AboutUsData(title: "Our Mission", desc: "At Kryupa, our mission is to enhance the quality of life for individuals in need by providing them access to professional, trustworthy, and empathetic caregivers. We believe in creating a community where care is not just a service but a bond built on trust, respect, and understanding."),
        AboutUsData(title: "What We Do", desc: "We offer a comprehensive platform where care seekers can easily find and connect with caregivers who meet their specific needs. Whether you require assistance for yourself, a loved one, or wish to offer your caregiving services, Kryupa is here to make that connection simple, secure, and satisfying."),
        AboutUsData(title: "Our Vision", desc: "We envision a world where everyone, regardless of their circumstances, has access to high-quality care. Kryupa aims to become the leading platform for caregiving services, known for our commitment to excellence, compassion, and innovation.\nJoin us in our journey to make caregiving a better experience for all. Whether you need care or want to offer it, Kryupa is here to support you every step of the way."),
        AboutUsData(title: "Terms & Conditions", desc: "Effective Date: 14-08-2024\nWelcome to Kryupa! By using our app or website, you agree to these Terms and Conditions, so please read them carefully.")

    ]
    
    @State var arrBulletList = [
        AboutUsData(title: "Eligibility You must be 18 years or older to use Kryupa. By creating an account, you confirm that you meet this requirement.", desc: ""),
        AboutUsData(title: "Account Registration You are responsible for providing accurate information and keeping your account credentials secure. Kryupa may conduct background checks on caregivers.", desc: ""),
        AboutUsData(title: "Services Provided Kryupa connects care seekers with caregivers for physical therapy, occupational therapy, nursing, and other non-medical services. Caregivers operate independently, and Kryupa is not responsible for the services provided.", desc: ""),
        AboutUsData(title: "Payment and Fees Payment is processed through Kryupa. Cancellations may incur fees based on Kryupa’s policy.", desc: ""),
        AboutUsData(title: "Healthcare Compliance Kryupa offers a range of services, including physical therapy, occupational therapy, and nursing. Caregivers providing these services are expected to hold the necessary licenses and certifications as required by law.", desc: ""),
        AboutUsData(title: "User Responsibilities Care seekers must provide accurate information and ensure a safe environment for caregivers. Caregivers must deliver services professionally and comply with all applicable laws and regulations.", desc: ""),
        
        AboutUsData(title: "Limitation of Liability Kryupa is not liable for any issues arising from the services provided by caregivers or care seekers.", desc: ""),
        AboutUsData(title: "Termination Kryupa may terminate your account for any reason. Users can also deactivate their accounts at any time.", desc: ""),
        AboutUsData(title: "Modifications to Terms Kryupa may update these terms. Continued use of the platform indicates acceptance of the changes.", desc: ""),
        AboutUsData(title: "Governing Law These terms are governed by U.S. law. Any disputes will be resolved in U.S. courts.", desc: ""),
        AboutUsData(title: "Contact Us\nFor questions, contact us at Example@kryupa.com.", desc: "")
    ]

    var body: some View {
        VStack {
            HeaderView(title: "About Caregiver",showBackButton: true)
            ScrollView {
                    ForEach(Array(arrAboutUs.enumerated()), id: \.offset) { index, model in
                        getParaView(title: model.title, desc: model.desc)
                    }
                    ForEach(Array(arrBulletList.enumerated()), id: \.offset) { index, model in
                        getBulletPointList(text: model.title)
                    }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 25)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    func getBulletPointList(text :String) -> some View {
        HStack(alignment: .top) {
            Text("•") // Unicode bullet point character
                .fontWeight(.semibold)

            Text(text)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(._444446)

            Spacer()
        }
        .padding(.leading)
        .padding(.vertical, 5)
    }
    
    func getParaView(title: String, desc: String) -> some View{
        
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.custom(FontContent.besMedium, size: 16))
                .foregroundStyle(._242426)
            
            Text(desc)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(._444446)
        }
        .padding(.vertical, 15)
    }
}

struct AboutUsData {
    let title: String
    let desc: String
}

#Preview {
    AboutUsView()
}
