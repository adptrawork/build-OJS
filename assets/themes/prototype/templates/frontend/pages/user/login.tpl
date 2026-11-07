{**
 * templates/frontend/pages/user/login.tpl
 * Halaman Login OJS
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<div class="login-page">
    <div class="login-container">
        <div class="content-card login-card">

            <!-- Header Icon & Title -->
            <div class="login-header">
                <div class="login-icon">
                    <svg width="32" height="32" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                        <polyline points="10 17 15 12 10 7"></polyline>
                        <line x1="15" y1="12" x2="3" y2="12"></line>
                    </svg>
                </div>
                <h1 class="login-title">Masuk ke Akun OJS</h1>
                <p class="login-subtitle">{$currentJournal->getLocalizedName()|escape|default:'Jurnal Ekonomi dan Bisnis JRDC'}</p>
            </div>

            <!-- Error Message -->
            {if $error}
                <div class="alert-error">
                    {$error|escape}
                </div>
            {/if}

            <!-- Form Login -->
            <form action="{url page="login" op="signIn"}" method="post" class="login-form">
                {csrf}
                <input type="hidden" name="source" value="{$source|escape|default:''}">

                <div class="form-group">
                    <label for="username">Nama Pengguna atau Surel</label>
                    <input type="text" name="username" id="username" required class="form-control"
                           placeholder="username atau email@domain.com"
                           value="{$username|escape|default:''}">
                </div>

                <div class="form-group">
                    <div class="label-row">
                        <label for="password">Kata Sandi</label>
                        <a href="{url page="login" op="lostPassword"}" class="link-forgot">Lupa sandi?</a>
                    </div>
                    <input type="password" name="password" id="password" required class="form-control"
                           placeholder="••••••••" autocomplete="current-password">
                </div>

                <div class="remember-me">
                    <input type="checkbox" name="remember" id="remember" class="check-input">
                    <label for="remember">Ingat saya di perangkat ini</label>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">
                    Masuk Dashboard OJS
                </button>
            </form>

            <div class="login-footer">
                <p>Belum punya akun penulis? <a href="{url page="user" op="register"}">Daftar Akun Baru</a></p>
            </div>

        </div>
    </div>
</div>

{include file="frontend/components/footer.tpl"}
