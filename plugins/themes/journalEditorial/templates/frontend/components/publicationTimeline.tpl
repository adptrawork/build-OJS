{**
 * @file plugins/themes/akdisi/templates/frontend/components/publicationTimeline.tpl
 *
 * 6 langkah editorial workflow (S-HOME-13).
 * Bisa diisi lewat custom block `akdisiTimeline`, fallback ke teks statis.
 *}
<section class="akdisi-timeline" data-slot="S-HOME-13" aria-labelledby="akdisi-timeline-heading">
	<div class="akdisi-timeline__inner">
		<h2 id="akdisi-timeline-heading">Publication Workflow</h2>
		<ol class="akdisi-timeline__list">
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">1</span>
				<div class="akdisi-timeline__body">
					<h3>Manuscript Submission</h3>
					<p>Authors submit the manuscript through the online submission system.</p>
				</div>
			</li>
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">2</span>
				<div class="akdisi-timeline__body">
					<h3>Initial Screening</h3>
					<p>Editorial team checks scope, formatting, and originality (plagiarism check).</p>
				</div>
			</li>
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">3</span>
				<div class="akdisi-timeline__body">
					<h3>Double-Blind Peer Review</h3>
					<p>At least two independent reviewers evaluate the manuscript anonymously.</p>
				</div>
			</li>
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">4</span>
				<div class="akdisi-timeline__body">
					<h3>Revision &amp; Decision</h3>
					<p>Authors revise based on reviewers' comments; editor makes final decision.</p>
				</div>
			</li>
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">5</span>
				<div class="akdisi-timeline__body">
					<h3>Copyediting &amp; DOI</h3>
					<p>Accepted articles are copyedited, galleys prepared, and DOI assigned.</p>
				</div>
			</li>
			<li class="akdisi-timeline__step">
				<span class="akdisi-timeline__number">6</span>
				<div class="akdisi-timeline__body">
					<h3>Online Publication</h3>
					<p>Article is published online and indexed by major academic databases.</p>
				</div>
			</li>
		</ol>
	</div>
</section>
