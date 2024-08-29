
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
  <#if section= "form">    
    <div class="full-bg-container">
      <div class="d-flex justify-content-end align-items-center h-100">
        <div class="login-container d-flex flex-column justify-content-between">
          <div class="text-center">
            <img height="85" src="${url.resourcesPath}/img/logo.png" alt="NagaWorld Logo" />
            <div class="divider"><h5>Single Sign On</h5></div>
            <p><small class="text-body-secondary">Access multiple applications and systems seamlessly with your work Email or else MyPortal login.</small>
            </p>
          </div>
          
          <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
              <div class="${properties.kcFormGroupClass!}">
                <div class="mb-3">
                  <label for="username" class="${properties.kcLabelClass!} form-label">
                    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}
                    </#if>
                  </label>

                  <#if usernameEditDisabled??>
                    <input tabindex="1" id="username" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="username" value="${(login.username!'')}" type="text" disabled="disabled"/>
                  <#else>
                    <input tabindex="1" id="username" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="username" value="${(login.username!'')}" type="text" autofocus="autofocus" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>

                    <#if messagesPerField.existsError('username','password')>
                      <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                      </span>
                    </#if>
                  </#if>
                </div>
              </div>

              <div class="${properties.kcFormGroupClass!}">
                <div class="mb-3">
                  <label for="password" class="${properties.kcLabelClass!} form-label">${msg("password")}</label>

                  <input tabindex="2" id="password" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="password" type="password" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                </div>
              </div>

              <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                <div id="kc-form-options">
                  <#if realm.rememberMe&&!usernameEditDisabled??>
                    <#if login.rememberMe??>
                      <div class="form-check">
                        <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked="checked">
                        <label class="form-check-label" for="rememberMe">
                          ${msg("rememberMe")}
                        </label>
                      </div>
                      <#--  <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}  -->
                    <#else>
                      <div class="form-check">
                        <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                        <label class="form-check-label" for="rememberMe">
                          ${msg("rememberMe")}
                        </label>
                      </div>
                      <#--  <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> <label>${msg("rememberMe")}</label>  -->
                    </#if>
                  </#if>
                  <div class="${properties.kcFormOptionsWrapperClass!}">
                    <#if realm.resetPasswordAllowed>
                      <span>
                        <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                      </span>
                    </#if>
                  </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} d-grid gap-2">
                  <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                  <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn-nagaworld" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                </div>
              </div>
            </form>
          </#if>
        </div>
      </div>
    </div>
  </#if>
</@layout.registrationLayout>