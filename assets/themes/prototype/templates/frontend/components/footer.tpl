{**
 * templates/frontend/components/footer.tpl
 * Prototype (Bootstrap-based) theme — Site footer
 * Maps prototype footer: 4-column (brand, Untuk Penulis, Navigasi & Arsip, Kontak & Sosial)
 * plus bottom bar. Dynamic data from OJS; social/contact fall back to sensible defaults.
 *}
	</main><!-- /.jrdc-main -->

	<footer class="jrdc-footer" role="contentinfo">
		<div class="jrdc-container">
			<div class="jrdc-footer-grid">
				{* Column 1: Brand *}
				<div>
					<div class="jrdc-footer-brand">
						{if $currentContext}
							{$currentContext->getLocalizedName()|escape}
						{else}
							{$siteTitle|escape}
						{/if}
					</div>
					<p style="margin:0;opacity:0.85;line-height:1.6;max-width:36ch;">
						Diterbitkan oleh
						<span style="opacity:1;font-weight:500;">
							{if $currentContext && $currentContext->getData('publisherInstitution')}{$currentContext->getData('publisherInstitution')|escape}{else}Penerbit{/if}
						</span>
						sebagai wadah diseminasi riset ilmiah dan publikasi kajian bidang ekonomi &amp; bisnis.
					</p>
					<div style="padding-top:0.5rem;border-top:1px solid rgba(255,255,255,0.08);font-size:0.6875rem;opacity:0.7;line-height:1.6;">
						Terbit berkala 2 kali setahun (April &amp; Oktober) • Akses Terbuka Peer-Reviewed.
					</div>
				</div>

				{* Column 2: Untuk Penulis *}
				<div>
					<strong style="color:#fff;display:block;margin-bottom:0.75rem;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.05em;">Untuk Penulis</strong>
					<ul style="list-style:none;margin:0;padding:0;font-size:0.75rem;line-height:2;">
						<li><a href="{url page="about" op="submissions"}">Pedoman Penulis</a></li>
						<li><a href="{url page="about"}">Fokus &amp; Ruang Lingkup</a></li>
						<li><a href="{url page="about"}">Etika Publikasi</a></li>
						<li><a href="{url page="about"}">Proses Peer Review</a></li>
						<li><a href="{url page="about" op="submissions"}">Kirim Naskah Online</a></li>
					</ul>
				</div>

				{* Column 3: Navigasi & Arsip *}
				<div>
					<strong style="color:#fff;display:block;margin-bottom:0.75rem;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.05em;">Navigasi &amp; Arsip</strong>
					<ul style="list-style:none;margin:0;padding:0;font-size:0.75rem;line-height:2;">
						<li><a href="{url page="index"}">Beranda</a></li>
						<li><a href="{url page="issue" op="current"}">Edisi Terbaru</a></li>
						<li><a href="{url page="issue" op="archive"}">Arsip Terbitan</a></li>
						<li><a href="{url page="about" op="editorialTeam"}">Dewan Redaksi</a></li>
						<li><a href="{url page="announcement"}">Pengumuman</a></li>
						<li><a href="{url page="about"}">Indeksasi &amp; Abstrak</a></li>
					</ul>
				</div>

				{* Column 4: Kontak & Sosial *}
				<div>
					<strong style="color:#fff;display:block;margin-bottom:0.75rem;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.05em;">Kontak &amp; Sekretariat</strong>
					<div style="font-size:0.75rem;line-height:1.8;opacity:0.85;">
						<div style="margin-bottom:0.5rem;">
							<span style="display:block;font-size:0.625rem;text-transform:uppercase;opacity:0.6;">Surel Redaksi</span>
							{if $currentContext && $currentContext->getData('contactEmail')}
								<a href="mailto:{$currentContext->getData('contactEmail')|escape}" style="color:#fbbf24;">{$currentContext->getData('contactEmail')|escape}</a>
							{else}
								<a href="mailto:jurnal@jrdc.ac.id" style="color:#fbbf24;">jurnal@jrdc.ac.id</a>
							{/if}
						</div>
						<div style="margin-bottom:0.5rem;">
							<span style="display:block;font-size:0.625rem;text-transform:uppercase;opacity:0.6;">Alamat Kantor</span>
							<span>{if $currentContext && $currentContext->getData('publisherInstitution')}{$currentContext->getData('publisherInstitution')|escape}{else}Gedung Ratu Dirgantara Cendekiawan, Jakarta, Indonesia{/if}</span>
						</div>
						<div style="margin-bottom:0.75rem;">
							<span style="display:block;font-size:0.625rem;text-transform:uppercase;opacity:0.6;">Jam Layanan</span>
							<span>Senin – Jumat: 08.00 – 16.00 WIB</span>
						</div>
					</div>
					<div style="padding-top:0.5rem;border-top:1px solid rgba(255,255,255,0.08);">
						<span style="display:block;font-size:0.625rem;text-transform:uppercase;opacity:0.6;margin-bottom:0.5rem;">Media Sosial</span>
						<div style="display:flex;flex-wrap:wrap;gap:0.5rem;">
							<a href="#" title="Instagram" style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:#cbd5e1;display:flex;align-items:center;justify-content:center;">IG</a>
							<a href="#" title="LinkedIn" style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:#cbd5e1;display:flex;align-items:center;justify-content:center;">in</a>
							<a href="#" title="X / Twitter" style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:#cbd5e1;display:flex;align-items:center;justify-content:center;">X</a>
							<a href="#" title="YouTube" style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:#cbd5e1;display:flex;align-items:center;justify-content:center;">YT</a>
							{if $currentContext && $currentContext->getData('contactEmail')}
								<a href="mailto:{$currentContext->getData('contactEmail')|escape}" title="Email" style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:#cbd5e1;display:flex;align-items:center;justify-content:center;">@</a>
							{/if}
						</div>
					</div>
				</div>
			</div>

			<div class="jrdc-footer-bottom">
				<div>
					{if $currentContext}
						{translate key="common.publishedBy"} {$currentContext->getData('publisherInstitution')|escape}
					{/if}
				</div>
				<div>
					{if $pageFooter}
						{$pageFooter}
					{else}
						&copy; {if $currentContext}{$currentContext->getLocalizedName()|escape}{else}{$siteTitle|escape}{/if}
					{/if}
				</div>
			</div>
		</div>
	</footer>

	{load_script context="frontend"}
</body>
</html>
