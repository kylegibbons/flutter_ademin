import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/term_condition/widgets/term_condition_content.dart';
import 'package:flutter_ademin/demo/page/term_condition/widgets/term_condition_header.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/general.dart';
import 'package:flutter_ademin/widgets/helper/html_render.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _StarterPageScreenState();
}

class _StarterPageScreenState extends State<TermConditionScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).termConditions; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    // Last updated date
    final String lastUpdatedDate = "April 28, 2025";

    return PortalMasterLayout(
      body: ListView(
        children: [
          //header
          PageHeader(
            title: lang.termConditions.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.termConditions, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth >= kScreenWidthXl
                  ? 4 * kDefaultPadding
                  : kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: Card(
              child: Column(
                children: [
                  // header
                  TermConditionHeader(lastUpdatedDate: lastUpdatedDate),

                  // content
                  const TermConditionContent(),

                  // approve button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 2 * kDefaultPadding,
                        right: 2 * kDefaultPadding,
                        bottom: 2 * kDefaultPadding,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlatButton(
                            kText: 'Accept',
                            bgColor: kSuccessColor,
                            kTextColor: Colors.white,
                            onPressed: () {},
                          ),
                          const SizedBox(width: kDefaultPadding),
                          CustomOutlinedButton(
                            kText: 'Decline',
                            outlineColor: kErrorColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

class TermsConditionsContent extends StatelessWidget {
  const TermsConditionsContent({super.key});

  // Mock privacy policy data using html tag
  final String termsConditionsContent = '''
<h2>1. Acceptance of Terms</h2>
<p>By accessing and using the Services, you affirm that you are of legal age to enter into these Terms or have obtained parental or guardian consent to do so. You agree to comply with these Terms and any additional terms and conditions that may apply to specific sections of the Services or to products and services available through the Services.</p>

<h2>2. Description of Services</h2>
<p>We provide [Description of Services]. We may change or discontinue any aspect of the Services at any time without notice.</p>

<h2>3. User Accounts</h2>
<ul>
    <li><span class="text-bold">Account Creation:</span> In order to access certain features of the Services, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.</li>
    <li><span class="text-bold">Account Security:</span> You are responsible for maintaining the confidentiality of your account credentials and are responsible for all activities that occur under your account. You agree to notify us immediately of any unauthorized access to your account or any other breach of security.</li>
    <li><span class="text-bold">Account Termination:</span> We reserve the right to suspend or terminate your account at any time for any reason, without notice.</li>
</ul>

<h2>4. Use of Services</h2>
<ul>
    <li><span class="text-bold">Acceptable Use:</span> You agree to use the Services only for lawful purposes and in accordance with these Terms. You agree not to:
        <ul>
            <li>Use the Services in any way that violates any applicable laws or regulations.</li>
            <li>Impersonate any person or entity or falsely state or misrepresent your affiliation with any person or entity.</li>
            <li>Interfere with or disrupt the operation of the Services or the servers or networks used to make the Services available.</li>
            <li>Attempt to gain unauthorized access to any portion of the Services or any other systems or networks connected to the Services.</li>
            <li>Use any robot, spider, scraper, or other automated means to access the Services for any purpose without our express written permission.</li>
            <li>Transmit any viruses, worms, or other malicious code.</li>
            <li>Engage in any activity that could interfere with the ability of others to use the Services.</li>
        </ul>
    </li>
    <li><span class="text-bold">Prohibited Content:</span> You agree not to post, upload, transmit, or otherwise make available through the Services any content that:
        <ul>
            <li>Is unlawful, harmful, threatening, abusive, harassing, tortious, defamatory, vulgar, obscene, libelous, invasive of another's privacy, hateful, or racially, ethnically, or otherwise objectionable.</li>
            <li>Infringes any patent, trademark, copyright, trade secret, or other proprietary right of any party.</li>
            <li>You do not have a right to make available under any law or contractual or fiduciary relationship.</li>
            <li>Contains software viruses or any other computer code, files, or programs designed to interrupt, destroy, or limit the functionality of any computer software or hardware or telecommunications equipment.</li>
        </ul>
    </li>
    <li><span class="text-bold">Monitoring:</span> We reserve the right to monitor your use of the Services and to remove any content that violates these Terms, but we are not obligated to do so.</li>
</ul>

<h2>5. Intellectual Property</h2>
<ul>
    <li><span class="text-bold">Our Content:</span> The Services and all content and materials included on the Services, including but not limited to text, graphics, images, logos, and software, are owned by or licensed to us and are protected by copyright, trademark, and other intellectual property laws.</li>
    <li><span class="text-bold">Your Content:</span> You retain ownership of any content you submit or make available through the Services. However, you grant us a non-exclusive, worldwide, royalty-free, perpetual, irrevocable, and sublicensable license to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content in connection with the Services.</li>
    <li><span class="text-bold">Restrictions:</span> You may not modify, copy, reproduce, republish, upload, post, transmit, or distribute any content from the Services without our express written permission.</li>
</ul>

<h2>6. User-Generated Content</h2>
<ul>
    <li><span class="text-bold">Responsibility:</span> You are solely responsible for any content you post, upload, or otherwise make available through the Services.</li>
    <li><span class="text-bold">License:</span> By posting, uploading, or making available any content through the Services, you grant us a license to use that content as described in Section 5.</li>
    <li><span class="text-bold">Representations and Warranties:</span> You represent and warrant that you have the right to post, upload, or make available such content and that such content does not violate these Terms.</li>
</ul>

<h2>7. Third-Party Links</h2>
<p>The Services may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the content, privacy policies, or practices of any third-party websites or services. You access such third-party websites or services at your own risk.</p>

<h2>8. Disclaimer of Warranties</h2>
<p><span class="text-bold">THE SERVICES ARE PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS. WE DISCLAIM ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE DO NOT WARRANT THAT THE SERVICES WILL BE UNINTERRUPTED, SECURE, OR ERROR-FREE.</span></p>

<h2>9. Limitation of Liability</h2>
<p><span class="text-bold">IN NO EVENT SHALL WE BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, INCLUDING BUT NOT LIMITED TO, LOSS OF PROFITS, DATA, OR GOODWILL, ARISING OUT OF OR IN CONNECTION WITH YOUR USE OF THE SERVICES, WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE), OR ANY OTHER LEGAL THEORY, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. OUR TOTAL LIABILITY TO YOU FOR ANY CLAIM ARISING OUT OF OR IN CONNECTION WITH THE SERVICES SHALL NOT EXCEED THE AMOUNT YOU PAID, IF ANY, TO ACCESS THE SERVICES.</span></p>

<h2>10. Indemnification</h2>
<p>You agree to indemnify and hold us harmless from and against any and all claims, liabilities, damages, losses, costs, and expenses, including reasonable attorneys' fees, arising out of or in connection with your use of the Services or your breach of these Terms.</p>

<h2>11. Governing Law</h2>
<p>These Terms shall be governed by and construed in accordance with the laws of [State/Country], without regard to its conflict of laws principles.</p>

<h2>12. Changes to These Terms</h2>
<p>We may update these Terms from time to time. We will notify you of any material changes by posting the new Terms on our Site and updating the effective date. You are advised to review these Terms periodically for any changes. Your continued use of the Services after the posting of changes constitutes your acceptance of such changes.</p>

<h2>13. Termination</h2>
<p>We may terminate your access to the Services at any time, for any reason, without notice. Upon termination, your right to use the Services will immediately cease.</p>

<h2>14. Severability</h2>
<p>If any provision of these Terms is held to be invalid or unenforceable, such provision shall be struck and the remaining provisions shall remain in full force and effect.</p>

<h2>15. Waiver</h2>
<p>No waiver of any provision of these Terms shall be effective unless in writing and signed by us.</p>

<h2>16. Entire Agreement</h2>
<p>These Terms constitute the entire agreement between you and us regarding your use of the Services and supersede all prior and contemporaneous agreements, understandings, and representations, whether oral or written.</p>

<h2>17. Contact Us</h2>
<p>If you have any questions about these Terms, please contact us at:</p>
<p>[Company Name]</p>
<p>[Company Address]</p>
<p>[Email Address]</p>
<p>[Phone Number]</p>
''';

  // Last updated date
  final String lastUpdatedDate = "April 28, 2025";

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with wave
        Stack(
          children: [
            // Background with wave
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200,
                width: double.infinity,
                color: kSecondaryColor.withValues(
                  alpha: 0.3,
                ), // Light cream background
              ),
            ),
            // Centered title and subtitle
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: kHeadlineSmall,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Last update: $lastUpdatedDate'),
                  const SizedBox(height: 2 * kDefaultPadding),
                ],
              ),
            ),
          ],
        ),

        //content
        Padding(
          padding: const EdgeInsets.only(
            left: 2 * kDefaultPadding,
            right: 2 * kDefaultPadding,
            top: 2 * kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: HtmlRender(data: termsConditionsContent),
        ),

        // approve button
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 2 * kDefaultPadding,
              right: 2 * kDefaultPadding,
              bottom: 2 * kDefaultPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton(
                  kText: 'Accept',
                  bgColor: kSuccessColor,
                  kTextColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(width: kDefaultPadding),
                CustomOutlinedButton(
                  kText: 'Decline',
                  outlineColor: kErrorColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
