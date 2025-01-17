<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="robots" content="noindex, nofollow">

   <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.png" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
  <script src="https://kit.fontawesome.com/34221fba87.js" crossorigin="anonymous"></script>
</head>

<body class="${properties.kcBodyClass!}">
<div class="${properties.kcLoginClass!}">
<div
id="kc-header" class="${properties.kcHeaderClass!}"><#--  <div id="kc-header-wrapper"
                                                                          class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>  -->
</div>
<div class="${properties.kcFormCardClass!}">
<header class="${properties.kcFormHeaderClass!}">
<#if realm.internationalizationEnabled && locale.supported?size gt 1>
<div class="row">
<div class="cs-locale col-sm-12 col-md-4 offset-md-4">
  <div class="btn-group">
    <a type="button" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      ${locale.current}
    </a>
    <ul class="dropdown-menu cs-dropdown-menu">
      <#list locale.supported as l>
        <li class="${properties.kcLocaleListItemClass!}">
          <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
        </li>
      </#list>
    </ul>
  </div>
</div>
</div>
<#--  <div class="${properties.kcLocaleMainClass!}" id="kc-locale">
                                                                                          <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!} row">
                                                                                              <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!} col-sm-12 col-md-4 offset-md-4">
                                                                                                  <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                                                                                  <ul class="${properties.kcLocaleListClass!}">
                                                                                                      <#list locale.supported as l>
                                                                                                          <li class="${properties.kcLocaleListItemClass!}">
                                                                                                              <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
                                                                                                          </li>
                                                                                                      </#list>
                                                                                                  </ul>
                                                                                              </div>
                                                                                          </div>
                                                                                      </div>  -->
</#if>
<#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
<#if displayRequiredFields>
<div class="${properties.kcContentWrapperClass!}">
  <div class="${properties.kcLabelWrapperClass!} subtitle">
    <span class="subtitle">
      <span class="required">*</span>
      ${msg("requiredFields")}</span>
  </div>
  <div class="col-md-10">
    <h1 id="kc-page-title">
      <#nested "header">
      </h1>
    </div>
  </div>
<#else>
  <h1 id="kc-page-title">
    <#nested "header">
    </h1>
  </#if>
<#else>
  <#if displayRequiredFields>
    <div class="${properties.kcContentWrapperClass!} row">
      <div class="${properties.kcLabelWrapperClass!} subtitle col-sm-12 col-md-4 offset-md-4 kc-forms">
        <span class="subtitle">
          <span class="required">*</span>
          ${msg("requiredFields")}</span>
      </div>
      <div class="col-sm-12 col-md-4 offset-md-4 kc-forms">
        <#nested "show-username">
          <div id="kc-username" class="${properties.kcFormGroupClass!}">
            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
            <a id="reset-login" href="${url.loginRestartFlowUrl}">
              <div class="kc-login-tooltip">
                <i class="${properties.kcResetFlowIcon!}"></i>
                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
              </div>
            </a>
          </div>
        </div>
      </div>
    <#else>
      <#nested "show-username">
        <div id="kc-username" class="${properties.kcFormGroupClass!} row">
          <div class="col-md-4 offset-md-4 col-sm-12 kc-forms cs-username">
            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
            <a id="reset-login" href="${url.loginRestartFlowUrl}">
              <div class="kc-login-tooltip">
                <i class="${properties.kcResetFlowIcon!}"></i>
                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
              </div>
            </a>
          </div>
        </div>
      </#if>
    </#if>
  </header>
  <div id="kc-content">
    <div id="kc-content-wrapper">

      <#-- App-initiated actions should not see warning messages about the need to complete the action -->
      <#-- during login. -->

        <#if displayMessage&&message?has_content && (message.type!='warning' || !isAppInitiatedAction??)>
          <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if> row"> <div
            class="pf-c-alert__icon col-sm-12 col-md-4 offset-md-4">
            <#--  <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                                                                                                                                                                  <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                                                                                                                                                                  <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                                                                                                                                                                  <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>  -->
            <#if message.type = 'success'>
              <div class="alert alert-success cs-alert-message">
                <i class="fa-solid fa-circle-check"></i>
              </#if>

              <#if message.type = 'warning'>
                <div class="alert alert-warning cs-alert-message">
                  <i class="fa-solid fa-circle-exclamation"></i>
                </#if>

                <#if message.type = 'error'>
                  <div class="alert alert-danger cs-alert-message">
                    <i class="fa-solid fa-circle-exclamation"></i>
                  </#if>

                  <#if message.type = 'info'>
                    <div class="alert alert-info cs-alert-message">
                      <i class="fa-solid fa-circle-info"></i>
                    </#if>
                    <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                  </div>
                </div>
              </div>
            </#if>

            <#nested "form">

              <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                  <div class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="tryAnotherWay" value="on"/>
                    <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                  </div>
                </form>
              </#if>

              <#if displayInfo>
                <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                    <#nested "info">
                    </div>
                  </div>
                </#if>
              </div>
            </div>

          </div>
        </div>
      </body>
    </html>
  </#macro>
