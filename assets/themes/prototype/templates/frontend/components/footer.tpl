{**
 * templates/frontend/components/footer.tpl
 *}
	</main><!-- /.jrdc-main -->

	<footer class="jrdc-footer">
		<div class="jrdc-container">
			<div class="jrdc-footer-grid">

				<div class="jrdc-footer-col">
					<div class="jrdc-footer-brand-box">
						<svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
							<rect x="4" y="4" width="56" height="56" rx="12" fill="#0F284E" stroke="#D4AF37" stroke-width="2"></rect>
							<path d="M18 42C23 39.5 28.5 39.8 32 42.5C35.5 39.8 41 39.5 46 42V26C41 23.5 35.5 23.8 32 26.5C28.5 23.8 23 23.5 18 26V42Z" fill="none" stroke="#FFFFFF" stroke-width="1.8"></path>
							<line x1="32" y1="26.5" x2="32" y2="42.5" stroke="#FFFFFF" stroke-width="1.8"></line>
						</svg>
						<div>
							<span class="jrdc-footer-brand-title">Jurnal Ratu Dirgantara</span>
							<span class="jrdc-footer-brand-sub">Cendekiawan</span>
						</div>
					</div>
					<p class="jrdc-footer-desc">
						Diterbitkan oleh <strong>{$currentContext->getData('publisherInstitution')|escape|default:'Yayasan Ratu Dirgantara Cendekiawan (JRDC)'}</strong> sebagai wadah diseminasi riset ilmiah dan publikasi kajian bidang ekonomi &amp; bisnis.
					</p>
					<div class="jrdc-footer-note">
						Terbit berkala 2 kali setahun (April &amp; Oktober) • Akses Terbuka Peer-Reviewed.
					</div>
				</div>

				<div class="jrdc-footer-col">
					<h4 class="jrdc-footer-heading">Untuk Penulis</h4>
					<ul class="jrdc-footer-links">
						<li><a href="{url page="about" op="submissions"}">› Pedoman Penulis</a></li>
						<li><a href="{url page="about"}">› Fokus &amp; Ruang Lingkup</a></li>
						<li><a href="{url page="about"}">› Etika Publikasi</a></li>
						<li><a href="{url page="about"}">› Proses Peer Review</a></li>
						<li><a href="{url page="about" op="submissions"}">› Templat Naskah (.docx)</a></li>
						<li><a href="{url page="submission" op="wizard"}">› Kirim Naskah Online</a></li>
					</ul>
				</div>

				<div class="jrdc-footer-col">
					<h4 class="jrdc-footer-heading">Navigasi &amp; Arsip</h4>
					<ul class="jrdc-footer-links">
						<li><a href="{url page="index"}">› Beranda</a></li>
						<li><a href="{url page="issue" op="current"}">› Edisi Terbaru</a></li>
						<li><a href="{url page="issue" op="archive"}">› Arsip Terbitan</a></li>
						<li><a href="{url page="about" op="editorialTeam"}">› Dewan Redaksi</a></li>
						<li><a href="{url page="announcement"}">› Pengumuman</a></li>
						<li><a href="{url page="about"}">› Indeksasi &amp; Abstrak</a></li>
					</ul>
				</div>

				<div class="jrdc-footer-col">
					<h4 class="jrdc-footer-heading">Kontak &amp; Sekretariat</h4>
					<div class="jrdc-footer-contact">
						<div>
							<span class="jrdc-contact-label">Surel Redaksi</span>
							<a href="mailto:{$currentContext->getData('contactEmail')|escape|default:'jurnal@jrdc.ac.id'}">{$currentContext->getData('contactEmail')|escape|default:'jurnal@jrdc.ac.id'}</a>
						</div>
						<div>
							<span class="jrdc-contact-label">Alamat Kantor</span>
							<span class="jrdc-contact-text">{$currentContext->getData('mailingAddress')|escape|default:'Gedung Ratu Dirgantara Cendekiawan, Jakarta'}</span>
						</div>
						<div>
							<span class="jrdc-contact-label">Jam Layanan</span>
							<span class="jrdc-contact-text">Senin – Jumat: 08.00 – 16.00 WIB</span>
						</div>
					</div>

					<div class="jrdc-footer-social-wrap">
						<span class="jrdc-contact-label">Media Sosial</span>
						<div class="jrdc-social-icons">
							<a href="#" title="Instagram">
								<svg fill="currentColor" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"></path></svg>
							</a>
							<a href="#" title="LinkedIn">
								<svg fill="currentColor" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"></path></svg>
							</a>
							<a href="#" title="YouTube">
								<svg fill="currentColor" viewBox="0 0 24 24"><path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"></path></svg>
							</a>
							<a href="mailto:{$currentContext->getData('contactEmail')|escape|default:'jurnal@jrdc.ac.id'}" title="Email">
								<svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
							</a>
						</div>
					</div>
				</div>

			</div>

			<div class="jrdc-footer-bottom">
				<div class="jrdc-footer-copy">
					&copy; {date('Y')} {$currentContext->getLocalizedName()|escape} — Powered by Open Journal Systems
				</div>
				<div class="jrdc-footer-legal">
					<a href="{url page="about"}">Kebijakan Privasi</a>
					<span>•</span>
					<a href="{url page="about"}">Pemberitahuan Hak Cipta</a>
					<span>•</span>
					<a href="{url page="about"}">Pernyataan Akses Terbuka</a>
				</div>
			</div>
		</div>
	</footer>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var btn = document.getElementById('jrdc-mobile-btn');
			var nav = document.getElementById('jrdc-mobile-nav');
			if (btn && nav) {
				btn.addEventListener('click', function() {
					nav.classList.toggle('open');
				});
			}
		});
	</script>

	{load_script context="frontend"}
</body>
</html>
