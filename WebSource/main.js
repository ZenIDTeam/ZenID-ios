"use strict";
(self["webpackChunkmobile"] = self["webpackChunkmobile"] || []).push([["main"],{

/***/ 7643:
/*!**************************************************************!*\
  !*** ./apps/mobile/src/app/analyzing/analyzing.component.ts ***!
  \**************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AnalyzingComponent": () => (/* binding */ AnalyzingComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);







function AnalyzingComponent_ng_template_0_lottie_player_3_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](0, "lottie-player", 15);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function AnalyzingComponent_ng_template_0_div_10_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](1, "div", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} }
function AnalyzingComponent_ng_template_0_div_11_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](1, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} }
function AnalyzingComponent_ng_template_0_div_14_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("analyzing." + ctx_r5.selfieVerification), " ");
} }
function AnalyzingComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](3, AnalyzingComponent_ng_template_0_lottie_player_3_Template, 1, 1, "lottie-player", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](6, "div", 6)(7, "div", 7)(8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](9, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](10, AnalyzingComponent_ng_template_0_div_10_Template, 2, 0, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](11, AnalyzingComponent_ng_template_0_div_11_Template, 2, 0, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](12, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](14, AnalyzingComponent_ng_template_0_div_14_Template, 2, 1, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](15, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("analyzing.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("analyzing.document"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
} }
class AnalyzingComponent {
    constructor(uiService, messageService) {
        this.uiService = uiService;
        this.messageService = messageService;
        this.animationSrc = JSON.stringify(this.uiService.animations['analyzing']);
        this.statusesSelfieForShow = ['selfie', 'liveness', 'livenessLegacy'];
        if (this.messageService.dataToSend.previousEvent?.data?.selfieVerification) {
            this.selfieVerification = this.messageService.dataToSend.previousEvent?.data?.selfieVerification;
            this.showExpanded = this.statusesSelfieForShow.includes(this.selfieVerification);
        }
        else {
            this.selfieVerification = 'none';
            this.showExpanded = false;
        }
    }
}
AnalyzingComponent.ɵfac = function AnalyzingComponent_Factory(t) { return new (t || AnalyzingComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_1__.MessageService)); };
AnalyzingComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: AnalyzingComponent, selectors: [["mobile-analyzing"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "grow"], ["autoplay", "", "loop", "", "mode", "normal", "class", "h-fit sm:h-40", 3, "src", 4, "ngIf"], [1, "mb-8", "text-center", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "grid", "grid-flow-col", "grid-rows-2", "gap-x-4", "gap-y-6"], [1, "row-span-2", "flex", "flex-col", "items-end"], [1, "flex", "h-6", "w-6", "items-center", "justify-center", "rounded-full", "bg-light-gray-01", "dark:bg-dark-gray-01"], [1, "ci-check", "text-light-base-02", "dark:text-dark-base-02"], ["class", "flex w-6 grow flex-row justify-center", 4, "ngIf"], ["class", "flex h-6 w-6 items-center justify-center rounded-full bg-light-gray-01 dark:bg-dark-gray-01", 4, "ngIf"], [1, "text-left", "text-s15", "text-light-base-01", "dark:text-dark-base-01"], ["class", "text-left text-s15 text-light-base-01 dark:text-dark-base-01", 4, "ngIf"], [1, "grow", "sm:hidden"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"], [1, "flex", "w-6", "grow", "flex-row", "justify-center"], [1, "h-full", "w-[1px]", "bg-light-gray-01", "dark:bg-dark-gray-01"]], template: function AnalyzingComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, AnalyzingComponent_ng_template_0_Template, 16, 6, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_3__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJhbmFseXppbmcuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 5932:
/*!**********************************************!*\
  !*** ./apps/mobile/src/app/app.component.ts ***!
  \**********************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AppComponent": () => (/* binding */ AppComponent)
/* harmony export */ });
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../environments/environment */ 3238);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/core */ 2560);








class AppComponent {
    constructor(router, cd, messageService) {
        this.router = router;
        this.cd = cd;
        this.messageService = messageService;
        this.title = 'mobile';
        this.modalId = 'document.help';
        this.routerSub = this.router.events.subscribe((routerEvent) => {
            if (routerEvent instanceof _angular_router__WEBPACK_IMPORTED_MODULE_3__.NavigationStart) {
                if (routerEvent.navigationTrigger === 'popstate') {
                    // not allowed. Navigate to the same route
                    this.router.navigateByUrl(this.router.routerState.snapshot.url);
                }
            }
            if (routerEvent instanceof _angular_router__WEBPACK_IMPORTED_MODULE_3__.NavigationEnd) {
                // const event = new CustomEvent('routeChanged', { detail: { url: routerEvent.url } });
                // this.uiService.close(this.modalId);
                // window.dispatchEvent(event);
                console.log('Route changed to: ' + routerEvent.url);
            }
        });
        // set theme
        (0,_zenid_util__WEBPACK_IMPORTED_MODULE_0__.setThemeColors)(_environments_environment__WEBPACK_IMPORTED_MODULE_1__.environment.settings.Colors);
        (0,_zenid_util__WEBPACK_IMPORTED_MODULE_0__.triggerDarkMode)(_environments_environment__WEBPACK_IMPORTED_MODULE_1__.environment.settings.darkMode);
    }
    changeRoute(event) {
        this.messageService.customEventReceived(event.detail);
    }
    // @HostListener('window:showHelp', ['$event'])
    // triggerHelp(event: CustomEvent) {
    //     if (event.detail.showHelp) {
    //         this.uiService.open(this.modalId);
    //     } else {
    //         this.uiService.close(this.modalId);
    //     }
    // }
    ngOnDestroy() {
        this.routerSub.unsubscribe();
    }
}
AppComponent.ɵfac = function AppComponent_Factory(t) { return new (t || AppComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_4__.ChangeDetectorRef), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_2__.MessageService)); };
AppComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdefineComponent"]({ type: AppComponent, selectors: [["mobile-root"]], hostBindings: function AppComponent_HostBindings(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("webview", function AppComponent_webview_HostBindingHandler($event) { return ctx.changeRoute($event); }, false, _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresolveWindow"]);
    } }, decls: 2, vars: 0, consts: [[1, "flex", "w-screen", "justify-center", "pt-0", "sm:py-12"]], template: function AppComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](1, "router-outlet");
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_3__.RouterOutlet], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJhcHAuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 8095:
/*!*******************************************!*\
  !*** ./apps/mobile/src/app/app.module.ts ***!
  \*******************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AppModule": () => (/* binding */ AppModule)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_18__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_21__ = __webpack_require__(/*! @angular/platform-browser */ 4497);
/* harmony import */ var _app_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./app.component */ 5932);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_22__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _document_document_module__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./document/document.module */ 7171);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_23__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _zenid_ui__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @zenid/ui */ 9142);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_20__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_19__ = __webpack_require__(/*! @angular/common/http */ 8987);
/* harmony import */ var _welcome_welcome_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./welcome/welcome.component */ 6);
/* harmony import */ var _scan_scan_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./scan/scan.component */ 7629);
/* harmony import */ var _home_home_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./home/home.component */ 7301);
/* harmony import */ var _common_interceptors_root_interceptor__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ./common/interceptors/root.interceptor */ 4741);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_24__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_16__ = __webpack_require__(/*! rxjs */ 9346);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_17__ = __webpack_require__(/*! rxjs */ 9337);
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ../environments/environment */ 3238);
/* harmony import */ var _camera_camera_component__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ./camera/camera.component */ 1699);
/* harmony import */ var _settings_settings_module__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! ./settings/settings.module */ 2118);
/* harmony import */ var _selfie_selfie_module__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! ./selfie/selfie.module */ 5368);
/* harmony import */ var _liveness_check_liveness_check_module__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! ./liveness-check/liveness-check.module */ 949);
/* harmony import */ var _loading_loading_component__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! ./loading/loading.component */ 7277);
/* harmony import */ var _analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_14__ = __webpack_require__(/*! ./analyzing/analyzing.component */ 7643);
/* harmony import */ var _results_results_component__WEBPACK_IMPORTED_MODULE_15__ = __webpack_require__(/*! ./results/results.component */ 296);



























const routes = [
    { path: '', component: _app_component__WEBPACK_IMPORTED_MODULE_0__.AppComponent },
    { path: 'welcome', component: _welcome_welcome_component__WEBPACK_IMPORTED_MODULE_4__.WelcomeComponent },
    { path: 'camera', component: _camera_camera_component__WEBPACK_IMPORTED_MODULE_9__.CameraComponent },
    { path: 'scan', component: _scan_scan_component__WEBPACK_IMPORTED_MODULE_5__.ScanComponent },
    { path: 'home', component: _home_home_component__WEBPACK_IMPORTED_MODULE_6__.HomeComponent },
    { path: 'loading', component: _loading_loading_component__WEBPACK_IMPORTED_MODULE_13__.LoadingComponent },
    { path: 'analyzing', component: _analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_14__.AnalyzingComponent },
    { path: 'results', component: _results_results_component__WEBPACK_IMPORTED_MODULE_15__.ResultsComponent }
];
const loadFonts = () => {
    return () => {
        const functionFont = new FontFace('coolicons', `url(\'${_environments_environment__WEBPACK_IMPORTED_MODULE_8__.environment.config.appRoot}/assets/fonts/coolicons/coolicons.woff?fs2eqh\') format(\'woff\')`);
        return (0,rxjs__WEBPACK_IMPORTED_MODULE_16__.from)(functionFont.load()).pipe((0,rxjs__WEBPACK_IMPORTED_MODULE_17__.tap)((loadedFace) => document.fonts.add(loadedFace)));
    };
};
class AppModule {
}
AppModule.ɵfac = function AppModule_Factory(t) { return new (t || AppModule)(); };
AppModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_18__["ɵɵdefineNgModule"]({ type: AppModule, bootstrap: [_app_component__WEBPACK_IMPORTED_MODULE_0__.AppComponent] });
AppModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_18__["ɵɵdefineInjector"]({ providers: [
        { provide: _angular_core__WEBPACK_IMPORTED_MODULE_18__.APP_INITIALIZER, useFactory: loadFonts, multi: true },
        { provide: _angular_common_http__WEBPACK_IMPORTED_MODULE_19__.HTTP_INTERCEPTORS, useClass: _common_interceptors_root_interceptor__WEBPACK_IMPORTED_MODULE_7__.RootInterceptor, multi: true },
        { provide: _ngneat_transloco__WEBPACK_IMPORTED_MODULE_20__.TRANSLOCO_SCOPE, useValue: 'web-demo' }
    ], imports: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_21__.BrowserModule,
        _angular_router__WEBPACK_IMPORTED_MODULE_22__.RouterModule.forRoot(routes, { initialNavigation: 'disabled' }),
        _document_document_module__WEBPACK_IMPORTED_MODULE_1__.DocumentModule,
        _selfie_selfie_module__WEBPACK_IMPORTED_MODULE_11__.SelfieModule,
        _liveness_check_liveness_check_module__WEBPACK_IMPORTED_MODULE_12__.LivenessCheckModule,
        _zenid_util__WEBPACK_IMPORTED_MODULE_2__.UtilModule,
        _angular_forms__WEBPACK_IMPORTED_MODULE_23__.ReactiveFormsModule,
        _zenid_ui__WEBPACK_IMPORTED_MODULE_3__.UiModule,
        angular_svg_icon__WEBPACK_IMPORTED_MODULE_24__.AngularSvgIconModule.forRoot(),
        _settings_settings_module__WEBPACK_IMPORTED_MODULE_10__.SettingsModule, _angular_router__WEBPACK_IMPORTED_MODULE_22__.RouterModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_18__["ɵɵsetNgModuleScope"](AppModule, { declarations: [_app_component__WEBPACK_IMPORTED_MODULE_0__.AppComponent,
        _welcome_welcome_component__WEBPACK_IMPORTED_MODULE_4__.WelcomeComponent,
        _scan_scan_component__WEBPACK_IMPORTED_MODULE_5__.ScanComponent,
        _home_home_component__WEBPACK_IMPORTED_MODULE_6__.HomeComponent,
        _camera_camera_component__WEBPACK_IMPORTED_MODULE_9__.CameraComponent,
        _loading_loading_component__WEBPACK_IMPORTED_MODULE_13__.LoadingComponent,
        _analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_14__.AnalyzingComponent,
        _results_results_component__WEBPACK_IMPORTED_MODULE_15__.ResultsComponent], imports: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_21__.BrowserModule, _angular_router__WEBPACK_IMPORTED_MODULE_22__.RouterModule, _document_document_module__WEBPACK_IMPORTED_MODULE_1__.DocumentModule,
        _selfie_selfie_module__WEBPACK_IMPORTED_MODULE_11__.SelfieModule,
        _liveness_check_liveness_check_module__WEBPACK_IMPORTED_MODULE_12__.LivenessCheckModule,
        _zenid_util__WEBPACK_IMPORTED_MODULE_2__.UtilModule,
        _angular_forms__WEBPACK_IMPORTED_MODULE_23__.ReactiveFormsModule,
        _zenid_ui__WEBPACK_IMPORTED_MODULE_3__.UiModule, angular_svg_icon__WEBPACK_IMPORTED_MODULE_24__.AngularSvgIconModule, _settings_settings_module__WEBPACK_IMPORTED_MODULE_10__.SettingsModule], exports: [_angular_router__WEBPACK_IMPORTED_MODULE_22__.RouterModule] }); })();


/***/ }),

/***/ 1699:
/*!********************************************************!*\
  !*** ./apps/mobile/src/app/camera/camera.component.ts ***!
  \********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CameraComponent": () => (/* binding */ CameraComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);








function CameraComponent_ng_template_0_lottie_player_2_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](0, "lottie-player", 13);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function CameraComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](2, CameraComponent_ng_template_0_lottie_player_2_Template, 1, 1, "lottie-player", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](3, "p", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](5, "p", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](7, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](8, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](9, "div", 8)(10, "zenid-button", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function CameraComponent_ng_template_0_Template_zenid_button_click_10_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r4); const ctx_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r3.onOk()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](12, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](13, "div", 11)(14, "zenid-button", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function CameraComponent_ng_template_0_Template_zenid_button_click_14_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r4); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r5.onOk()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("cameraAccess.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("cameraAccess.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("cameraAccess.submitButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("cameraAccess.submitButton"), " ");
} }
class CameraComponent {
    constructor(uiService, messageService) {
        this.uiService = uiService;
        this.messageService = messageService;
        this.animationSrc = JSON.stringify(this.uiService.animations['camera']);
    }
    onOk() {
        this.messageService.sendNextPressed();
    }
}
CameraComponent.ɵfac = function CameraComponent_Factory(t) { return new (t || CameraComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_1__.MessageService)); };
CameraComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: CameraComponent, selectors: [["mobile-camera"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], ["loop", "", "autoplay", "", "mode", "normal", "class", "h-fit sm:h-40", 3, "src", 4, "ngIf"], [1, "mb-6", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-6", "text-s13", "font-normal", "text-light-base-02", "dark:text-dark-base-02", "sm:mb-10", "sm:px-20"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "click"], [1, "grow", "sm:hidden"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "click"], ["loop", "", "autoplay", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"]], template: function CameraComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, CameraComponent_ng_template_0_Template, 16, 5, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_4__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__.ButtonComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjYW1lcmEuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 4741:
/*!*********************************************************************!*\
  !*** ./apps/mobile/src/app/common/interceptors/root.interceptor.ts ***!
  \*********************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "RootInterceptor": () => (/* binding */ RootInterceptor)
/* harmony export */ });
/* harmony import */ var apps_mobile_src_environments_environment__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! apps/mobile/src/environments/environment */ 3238);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);



class RootInterceptor {
    constructor() {
        this.baseAssetsPath = '/assets';
    }
    intercept(req, next) {
        if (req.url.startsWith(this.baseAssetsPath)) {
            const newReq = req.clone({
                url: apps_mobile_src_environments_environment__WEBPACK_IMPORTED_MODULE_0__.environment.config.appRoot + req.url
            });
            return next.handle(newReq);
        }
        return next.handle(req);
    }
}
RootInterceptor.ɵfac = function RootInterceptor_Factory(t) { return new (t || RootInterceptor)(); };
RootInterceptor.ɵprov = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineInjectable"]({ token: RootInterceptor, factory: RootInterceptor.ɵfac });


/***/ }),

/***/ 5923:
/*!****************************************************************!*\
  !*** ./apps/mobile/src/app/common/services/message.service.ts ***!
  \****************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "MessageService": () => (/* binding */ MessageService)
/* harmony export */ });
/* harmony import */ var _settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ 124);





class MessageService {
    constructor(router, settingsService) {
        this.router = router;
        this.settingsService = settingsService;
        this.dataToSend = {};
    }
    sendBackPressed(eventDetail) {
        this.dataToSend.nextEvent = eventDetail;
        const dataToSend = { ...this.dataToSend };
        dataToSend.previousEvent.base64 = '';
        if (AndroidInterface) {
            AndroidInterface.backButtonPressed(JSON.stringify(dataToSend));
        }
    }
    sendNextPressed(eventDetail) {
        this.dataToSend.nextEvent = eventDetail;
        const dataToSend = { ...this.dataToSend };
        dataToSend.previousEvent.base64 = '';
        if (AndroidInterface) {
            AndroidInterface.nextButtonPressed(JSON.stringify(dataToSend));
        }
    }
    customEventReceived(eventDetail) {
        this.dataToSend.previousEvent = {
            ...eventDetail
        };
        this.router.navigateByUrl('/', { skipLocationChange: false }).then(() => {
            switch (eventDetail.feature) {
                case 'settings': {
                    if (eventDetail.data) {
                        this.settingsService.assembleForm(eventDetail.data);
                    }
                    this.router.navigate(['/settings']);
                    break;
                }
                case 'document': {
                    const queryParams = {
                        documentRole: eventDetail.role,
                        feedback: eventDetail.feedback
                    };
                    if (eventDetail.page === 'F') {
                        if (eventDetail.feedback === 'Ok') {
                            this.router.navigate(['/document/front-check'], { queryParams: queryParams });
                        }
                        else {
                            this.router.navigate(['/document/front'], { queryParams: queryParams });
                        }
                    }
                    else if (eventDetail.page === 'B') {
                        if (eventDetail.feedback === 'Ok') {
                            this.router.navigate(['/document/back-check'], { queryParams: queryParams });
                        }
                        else {
                            this.router.navigate(['/document/back'], { queryParams: queryParams });
                        }
                    }
                    else {
                        this.router.navigate(['/document'], { queryParams: queryParams });
                    }
                    break;
                }
                case 'selfie': {
                    if (!eventDetail.feedback) {
                        this.router.navigate(['/selfie']);
                    }
                    else if (eventDetail.feedback == 'Ok') {
                        this.router.navigate(['/selfie/check']);
                    }
                    else {
                        this.router.navigate(['/selfie/camera'], { queryParams: { feedback: eventDetail.feedback } });
                    }
                    break;
                }
                case 'selfieVideo': {
                    if (!eventDetail.feedback) {
                        this.router.navigate(['/liveness-check']);
                    }
                    else {
                        this.router.navigate(['/liveness-check/camera'], {
                            queryParams: { feedback: eventDetail.feedback }
                        });
                    }
                    break;
                }
                default: {
                    this.router.navigate([eventDetail.feature]);
                    break;
                }
            }
        });
    }
}
MessageService.ɵfac = function MessageService_Factory(t) { return new (t || MessageService)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵinject"](_angular_router__WEBPACK_IMPORTED_MODULE_2__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵinject"](_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
MessageService.ɵprov = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineInjectable"]({ token: MessageService, factory: MessageService.ɵfac, providedIn: 'root' });


/***/ }),

/***/ 8262:
/*!*****************************************************************!*\
  !*** ./apps/mobile/src/app/common/services/settings.service.ts ***!
  \*****************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SettingsService": () => (/* binding */ SettingsService)
/* harmony export */ });
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);



class SettingsService {
    constructor(fb) {
        this.fb = fb;
        this.form = this.fb.group({
            country: '',
            selfieVerification: '',
            DocumentsFilter: this.fb.array([]),
            DocumentsVerifier: this.fb.group({
                specularAcceptableScore: '',
                documentBlurAcceptableScore: '',
                timeToBlurMaxTolerance: '',
                showTimer: ''
            }),
            Colors: this.fb.group({
                primaryColor: '',
                contrastColor: ''
            }),
            debugMode: ''
        });
        this.filterForm = this.fb.group({
            Country: null,
            Role: null,
            Page: null
        });
    }
    assembleForm(settings) {
        // clear form
        this.documentsFilterArray.clear();
        this.form.reset();
        // assemble form
        settings.DocumentsFilter.forEach((value) => {
            this.documentsFilterArray.push(this.filterGroup);
        });
        this.form.patchValue(settings);
    }
    removeFilter(index) {
        if (this.documentsFilterArray.length > 1) {
            this.documentsFilterArray.removeAt(index);
        }
        else {
            this.documentsFilterArray.clear();
        }
    }
    appendFilter() {
        const filterGroup = this.filterGroup;
        filterGroup.setValue(this.filterForm.value);
        this.documentsFilterArray.push(filterGroup);
    }
    get filterGroup() {
        return new _angular_forms__WEBPACK_IMPORTED_MODULE_0__.FormGroup({
            Role: new _angular_forms__WEBPACK_IMPORTED_MODULE_0__.FormControl(''),
            Country: new _angular_forms__WEBPACK_IMPORTED_MODULE_0__.FormControl(''),
            Page: new _angular_forms__WEBPACK_IMPORTED_MODULE_0__.FormControl('')
        });
    }
    get documentsFilterArray() {
        return this.form.get('DocumentsFilter');
    }
}
SettingsService.ɵfac = function SettingsService_Factory(t) { return new (t || SettingsService)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵinject"](_angular_forms__WEBPACK_IMPORTED_MODULE_0__.UntypedFormBuilder)); };
SettingsService.ɵprov = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineInjectable"]({ token: SettingsService, factory: SettingsService.ɵfac, providedIn: 'root' });


/***/ }),

/***/ 3695:
/*!*************************************************************************!*\
  !*** ./apps/mobile/src/app/document/back-check/back-check.component.ts ***!
  \*************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "BackCheckComponent": () => (/* binding */ BackCheckComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/platform-browser */ 4497);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);









function BackCheckComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "a", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function BackCheckComponent_ng_template_0_Template_a_click_3_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](9, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](10, "img", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](11, "div", 10)(12, "div", 11)(13, "zenid-button", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function BackCheckComponent_ng_template_0_Template_zenid_button_click_13_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](15, "div", 13)(16, "zenid-button", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function BackCheckComponent_ng_template_0_Template_zenid_button_click_16_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r5.submit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](18, "div", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](19, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementContainerStart"](20);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](21, "zenid-button", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function BackCheckComponent_ng_template_0_Template_zenid_button_click_21_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.submit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](22);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](23, "p", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function BackCheckComponent_ng_template_0_Template_p_click_23_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r7.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](24);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementContainerEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.backCheck.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.backCheck.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("src", ctx_r0.imagePath, _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.backCheck.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".backCheck.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".backCheck.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.backCheck.backButton"), " ");
} }
class BackCheckComponent {
    constructor(route, messageService, sanitizer) {
        this.route = route;
        this.messageService = messageService;
        this.sanitizer = sanitizer;
        this.documentRole = this.route.snapshot.queryParams['documentRole'];
        this.imagePath = this.sanitizer.bypassSecurityTrustResourceUrl('data:image/jpg;base64,' + this.messageService.dataToSend.previousEvent?.base64);
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    submit() {
        this.messageService.sendNextPressed();
    }
}
BackCheckComponent.ɵfac = function BackCheckComponent_Factory(t) { return new (t || BackCheckComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_4__.DomSanitizer)); };
BackCheckComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: BackCheckComponent, selectors: [["mobile-back-check"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], [3, "click"], [1, "ci-short_left", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:text-s17"], [1, "mb-6", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:px-24"], ["id", "snapshot-preview", 1, "mb-8"], [3, "src"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "withIcon", "click"], [1, "grow", "sm:hidden"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "withIcon", "click"], [1, "mt-6", "text-s15", "text-light-base-00", "dark:text-dark-base-00", 3, "click"]], template: function BackCheckComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, BackCheckComponent_ng_template_0_Template, 25, 9, "ng-template", 0);
    } }, dependencies: [_libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJiYWNrLWNoZWNrLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 9141:
/*!*************************************************************!*\
  !*** ./apps/mobile/src/app/document/back/back.component.ts ***!
  \*************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "BackComponent": () => (/* binding */ BackComponent)
/* harmony export */ });
/* harmony import */ var libs_data_access_src_lib_ui_ui_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! libs/data-access/src/lib/ui/ui.service */ 7725);
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @ngneat/transloco */ 3091);












function BackComponent_ng_template_0_zenid_button_24_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "zenid-button", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("click", function BackComponent_ng_template_0_zenid_button_24_Template_zenid_button_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresetView"](ctx_r6.cycleCamera()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"]().$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.switchCamera"), " ");
} }
function BackComponent_ng_template_0_zenid_button_25_Template(rf, ctx) { if (rf & 1) {
    const _r10 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "zenid-button", 28);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("click", function BackComponent_ng_template_0_zenid_button_25_Template_zenid_button_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵrestoreView"](_r10); const ctx_r9 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresetView"](ctx_r9.snapNow()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"]().$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.snapNow"), " ");
} }
function BackComponent_ng_template_0_div_30_Template(rf, ctx) { if (rf & 1) {
    const _r13 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "div", 29);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("click", function BackComponent_ng_template_0_div_30_Template_div_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵrestoreView"](_r13); const ctx_r12 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresetView"](ctx_r12.snapNow()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](1, "div", 30);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
} }
function BackComponent_ng_template_0_svg_icon_32_Template(rf, ctx) { if (rf & 1) {
    const _r15 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "svg-icon", 31);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("click", function BackComponent_ng_template_0_svg_icon_32_Template_svg_icon_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵrestoreView"](_r15); const ctx_r14 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresetView"](ctx_r14.cycleCamera()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
} }
function BackComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "div", 1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](2, "div", 3)(3, "p", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](6, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](7, "lottie-player", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](9, "div", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](10, "p", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](12, "p", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](14, "div", 12)(15, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](16, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](18, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](19, "div", 15)(20, "zenid-button", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](21);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](22, "div", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](23, "div", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](24, BackComponent_ng_template_0_zenid_button_24_Template, 2, 1, "zenid-button", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](25, BackComponent_ng_template_0_zenid_button_25_Template, 2, 1, "zenid-button", 20);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](26, "div", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](27, "div", 22);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](28, "div");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](29, "div", 23);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](30, BackComponent_ng_template_0_div_30_Template, 2, 0, "div", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](31, "div", 25);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](32, BackComponent_ng_template_0_svg_icon_32_Template, 1, 0, "svg-icon", 26);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngClass", ctx_r0.feedback == ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound] ? "ci-search" : "ci-error");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound])), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate"]("src", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".back.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("document.common.back.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngClass", ctx_r0.feedback == ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound] ? "ci-search" : "ci-error");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound])), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngIf", ctx_r0.multipleCameras);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngIf", ctx_r0.showSnapNow);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngIf", ctx_r0.showSnapNow);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngIf", ctx_r0.multipleCameras);
} }
class BackComponent {
    constructor(route, uiService, messageService) {
        this.route = route;
        this.uiService = uiService;
        this.messageService = messageService;
        this.ZenidFeedback = libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__.ZenidFeedback;
        this.animationSrc = JSON.stringify(this.uiService.animations['id-back']);
        this.documentRole = this.route.snapshot.queryParams['documentRole'];
        this.feedback = this.route.snapshot.queryParams['feedback'];
        this.showSnapNow = false;
        this.multipleCameras = false;
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    cycleCamera() {
        // TODO
    }
    snapNow() {
        // TODO
    }
}
BackComponent.ɵfac = function BackComponent_Factory(t) { return new (t || BackComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_5__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](libs_data_access_src_lib_ui_ui_service__WEBPACK_IMPORTED_MODULE_0__.UiService), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_2__.MessageService)); };
BackComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdefineComponent"]({ type: BackComponent, selectors: [["mobile-back"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "camera-preview-overlay", "sm:hidden"], [1, "camera-preview-overlay-after", "sm:hidden"], [1, "pt-6", "text-center", "text-s22", "font-bold", "text-light-paper"], [1, "m-1", 3, "ngClass"], [1, "flex", "h-1/4", "flex-row", "justify-center", "sm:hidden"], ["autoplay", "", "loop", "", "mode", "normal", 1, "w-32", 3, "src"], [1, "main-container-mobile", "bg-opacity-0", "dark:bg-opacity-0", "sm:bg-opacity-100", "dark:sm:bg-opacity-100"], [1, "mb-10", "sm:hidden"], [1, "mb-4", "text-s22", "font-bold", "text-light-paper", "sm:text-s17", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], [1, "mb-6", "text-s13", "text-light-paper", "sm:px-24", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], [1, "mb-10", "hidden", "flex-row", "justify-center", "sm:flex"], [1, "negative-feedback"], ["id", "camera-preview"], [1, "mt-8", "hidden", "flex-row", "sm:flex"], ["classes", "secondary-button", "routerLink", "../info", "queryParamsHandling", "preserve"], [1, "grow"], [1, "flex", "space-x-4"], ["classes", "secondary-button", 3, "click", 4, "ngIf"], ["classes", "primary-button", 3, "click", 4, "ngIf"], [1, "grow", "sm:hidden"], [1, "grid", "h-[70px]", "grid-cols-3", "sm:hidden"], [1, "flex", "justify-center"], ["class", "flex w-[70px] items-center justify-center rounded-full bg-light-paper", 3, "click", 4, "ngIf"], [1, "flex", "justify-end"], ["src", "/assets/img/switch-camera.svg", "class", "flex items-center px-2", 3, "click", 4, "ngIf"], ["classes", "secondary-button", 3, "click"], ["classes", "primary-button", 3, "click"], [1, "flex", "w-[70px]", "items-center", "justify-center", "rounded-full", "bg-light-paper", 3, "click"], [1, "h-[56px]", "w-[56px]", "rounded-full", "border-2"], ["src", "/assets/img/switch-camera.svg", 1, "flex", "items-center", "px-2", 3, "click"]], template: function BackComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](0, BackComponent_ng_template_0_Template, 33, 12, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_6__.NgClass, _angular_common__WEBPACK_IMPORTED_MODULE_6__.NgIf, _angular_router__WEBPACK_IMPORTED_MODULE_5__.RouterLink, angular_svg_icon__WEBPACK_IMPORTED_MODULE_7__.SvgIconComponent, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_3__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_8__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJiYWNrLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 6418:
/*!************************************************************!*\
  !*** ./apps/mobile/src/app/document/document.component.ts ***!
  \************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DocumentComponent": () => (/* binding */ DocumentComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ 124);


class DocumentComponent {
    constructor() { }
    ngOnInit() { }
}
DocumentComponent.ɵfac = function DocumentComponent_Factory(t) { return new (t || DocumentComponent)(); };
DocumentComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: DocumentComponent, selectors: [["mobile-id"]], decls: 1, vars: 0, template: function DocumentComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "router-outlet");
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_1__.RouterOutlet], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJkb2N1bWVudC5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 7171:
/*!*********************************************************!*\
  !*** ./apps/mobile/src/app/document/document.module.ts ***!
  \*********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DocumentModule": () => (/* binding */ DocumentModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _document_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./document.component */ 6418);
/* harmony import */ var _front_front_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./front/front.component */ 6185);
/* harmony import */ var _front_check_front_check_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./front-check/front-check.component */ 2388);
/* harmony import */ var _back_back_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./back/back.component */ 9141);
/* harmony import */ var _back_check_back_check_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./back-check/back-check.component */ 3695);
/* harmony import */ var _zenid_ui__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @zenid/ui */ 9142);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _info_info_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ./info/info.component */ 9853);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @angular/core */ 2560);














const routes = [
    {
        path: 'document',
        component: _document_component__WEBPACK_IMPORTED_MODULE_0__.DocumentComponent,
        children: [
            {
                path: '',
                redirectTo: 'info',
                pathMatch: 'full'
            },
            {
                path: 'info',
                component: _info_info_component__WEBPACK_IMPORTED_MODULE_7__.InfoComponent
            },
            {
                path: 'front',
                component: _front_front_component__WEBPACK_IMPORTED_MODULE_1__.FrontComponent
            },
            {
                path: 'front-check',
                component: _front_check_front_check_component__WEBPACK_IMPORTED_MODULE_2__.FrontCheckComponent
            },
            {
                path: 'back',
                component: _back_back_component__WEBPACK_IMPORTED_MODULE_3__.BackComponent
            },
            {
                path: 'back-check',
                component: _back_check_back_check_component__WEBPACK_IMPORTED_MODULE_4__.BackCheckComponent
            }
        ]
    }
];
class DocumentModule {
}
DocumentModule.ɵfac = function DocumentModule_Factory(t) { return new (t || DocumentModule)(); };
DocumentModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_8__["ɵɵdefineNgModule"]({ type: DocumentModule });
DocumentModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_8__["ɵɵdefineInjector"]({ imports: [_angular_common__WEBPACK_IMPORTED_MODULE_9__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_10__.RouterModule.forChild(routes), angular_svg_icon__WEBPACK_IMPORTED_MODULE_11__.AngularSvgIconModule.forRoot(), _zenid_ui__WEBPACK_IMPORTED_MODULE_5__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_6__.UtilModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_8__["ɵɵsetNgModuleScope"](DocumentModule, { declarations: [_document_component__WEBPACK_IMPORTED_MODULE_0__.DocumentComponent,
        _front_front_component__WEBPACK_IMPORTED_MODULE_1__.FrontComponent,
        _front_check_front_check_component__WEBPACK_IMPORTED_MODULE_2__.FrontCheckComponent,
        _back_back_component__WEBPACK_IMPORTED_MODULE_3__.BackComponent,
        _back_check_back_check_component__WEBPACK_IMPORTED_MODULE_4__.BackCheckComponent,
        _info_info_component__WEBPACK_IMPORTED_MODULE_7__.InfoComponent], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_9__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_10__.RouterModule, angular_svg_icon__WEBPACK_IMPORTED_MODULE_11__.AngularSvgIconModule, _zenid_ui__WEBPACK_IMPORTED_MODULE_5__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_6__.UtilModule] }); })();


/***/ }),

/***/ 2388:
/*!***************************************************************************!*\
  !*** ./apps/mobile/src/app/document/front-check/front-check.component.ts ***!
  \***************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "FrontCheckComponent": () => (/* binding */ FrontCheckComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/platform-browser */ 4497);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);









function FrontCheckComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "a", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function FrontCheckComponent_ng_template_0_Template_a_click_3_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](9, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](10, "img", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](11, "div", 10)(12, "div", 11)(13, "zenid-button", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function FrontCheckComponent_ng_template_0_Template_zenid_button_click_13_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](15, "div", 13)(16, "zenid-button", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function FrontCheckComponent_ng_template_0_Template_zenid_button_click_16_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r5.submit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](18, "div", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](19, "div", 16)(20, "zenid-button", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function FrontCheckComponent_ng_template_0_Template_zenid_button_click_20_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.submit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](21);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](22, "p", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function FrontCheckComponent_ng_template_0_Template_p_click_22_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r7.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](23);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.frontCheck.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.frontCheck.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("src", ctx_r0.imagePath, _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.frontCheck.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".frontCheck.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".frontCheck.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.frontCheck.backButton"), " ");
} }
class FrontCheckComponent {
    constructor(route, messageService, sanitizer) {
        this.route = route;
        this.messageService = messageService;
        this.sanitizer = sanitizer;
        this.documentRole = this.route.snapshot.queryParams['documentRole'];
        this.imagePath = this.sanitizer.bypassSecurityTrustResourceUrl('data:image/jpg;base64,' + this.messageService.dataToSend.previousEvent?.base64);
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    submit() {
        this.messageService.sendNextPressed();
    }
}
FrontCheckComponent.ɵfac = function FrontCheckComponent_Factory(t) { return new (t || FrontCheckComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_4__.DomSanitizer)); };
FrontCheckComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: FrontCheckComponent, selectors: [["mobile-front-check"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], [3, "click"], [1, "ci-short_left", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:text-s17"], [1, "mb-6", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:px-24"], ["id", "snapshot-preview", 1, "mb-8"], [3, "src"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "withIcon", "click"], [1, "grow", "sm:hidden"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "withIcon", "click"], [1, "mt-6", "text-s15", "text-light-base-00", "dark:text-dark-base-00", 3, "click"]], template: function FrontCheckComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, FrontCheckComponent_ng_template_0_Template, 24, 9, "ng-template", 0);
    } }, dependencies: [_libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJmcm9udC1jaGVjay5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 6185:
/*!***************************************************************!*\
  !*** ./apps/mobile/src/app/document/front/front.component.ts ***!
  \***************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "FrontComponent": () => (/* binding */ FrontComponent)
/* harmony export */ });
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @ngneat/transloco */ 3091);










function FrontComponent_ng_template_0_div_7_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](0, "div", 26);
} }
function FrontComponent_ng_template_0_ng_template_8_Template(rf, ctx) { if (rf & 1) {
    const _r10 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 27)(1, "a", 28);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_ng_template_8_Template_a_click_1_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r10); const ctx_r9 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r9.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](2, "i", 29);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} }
function FrontComponent_ng_template_0_zenid_button_24_Template(rf, ctx) { if (rf & 1) {
    const _r12 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "zenid-button", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_zenid_button_24_Template_zenid_button_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r12); const ctx_r11 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r11.cycleCamera()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]().$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.switchCamera"), " ");
} }
function FrontComponent_ng_template_0_zenid_button_25_Template(rf, ctx) { if (rf & 1) {
    const _r15 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "zenid-button", 30);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_zenid_button_25_Template_zenid_button_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r15); const ctx_r14 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r14.snapNow()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]().$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.snapNow"), " ");
} }
function FrontComponent_ng_template_0_div_30_Template(rf, ctx) { if (rf & 1) {
    const _r18 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 31);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_div_30_Template_div_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r18); const ctx_r17 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r17.snapNow()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](1, "div", 32);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} }
function FrontComponent_ng_template_0_svg_icon_32_Template(rf, ctx) { if (rf & 1) {
    const _r20 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "svg-icon", 33);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_svg_icon_32_Template_svg_icon_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r20); const ctx_r19 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r19.cycleCamera()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} }
function FrontComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r22 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](2, "div", 3)(3, "p", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](6, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](7, FrontComponent_ng_template_0_div_7_Template, 1, 0, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](8, FrontComponent_ng_template_0_ng_template_8_Template, 3, 0, "ng-template", null, 8, _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplateRefExtractor"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](10, "p", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](12, "p", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](14, "div", 11)(15, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](16, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](18, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](19, "div", 14)(20, "zenid-button", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function FrontComponent_ng_template_0_Template_zenid_button_click_20_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r22); const ctx_r21 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r21.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](21);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](22, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](23, "div", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](24, FrontComponent_ng_template_0_zenid_button_24_Template, 2, 1, "zenid-button", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](25, FrontComponent_ng_template_0_zenid_button_25_Template, 2, 1, "zenid-button", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](26, "div", 20);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](27, "div", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](28, "div");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](29, "div", 22);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](30, FrontComponent_ng_template_0_div_30_Template, 2, 0, "div", 23);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](31, "div", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](32, FrontComponent_ng_template_0_svg_icon_32_Template, 1, 0, "svg-icon", 25);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵreference"](9);
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngClass", ctx_r0.feedback == ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound] ? "ci-search" : "ci-error");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound])), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.documentRole === "Sec")("ngIfElse", _r3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".front.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngClass", ctx_r0.feedback == ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound] ? "ci-search" : "ci-error");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : ctx_r0.ZenidFeedback[ctx_r0.ZenidFeedback.NoMatchFound])), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("document.common.front.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.multipleCameras);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.showSnapNow);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.showSnapNow);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.multipleCameras);
} }
class FrontComponent {
    constructor(route, messageService) {
        this.route = route;
        this.messageService = messageService;
        this.ZenidFeedback = libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__.ZenidFeedback;
        this.documentRole = this.route.snapshot.queryParams['documentRole'];
        this.feedback = this.route.snapshot.queryParams['feedback'];
        this.showSnapNow = false;
        this.multipleCameras = false;
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    cycleCamera() {
        // TODO
    }
    snapNow() {
        // TODO
    }
}
FrontComponent.ɵfac = function FrontComponent_Factory(t) { return new (t || FrontComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_1__.MessageService)); };
FrontComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: FrontComponent, selectors: [["mobile-id-front"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "camera-preview-overlay", "sm:hidden"], [1, "camera-preview-overlay-after", "sm:hidden"], [1, "pt-6", "text-center", "text-s22", "font-bold", "text-light-paper"], [1, "m-1", 3, "ngClass"], [1, "main-container-mobile", "bg-opacity-0", "dark:bg-opacity-0", "sm:bg-opacity-100", "dark:sm:bg-opacity-100"], ["class", "mb-10 sm:hidden", 4, "ngIf", "ngIfElse"], ["elseBlock", ""], [1, "mb-4", "text-s22", "font-bold", "text-light-paper", "sm:text-s17", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], [1, "mb-6", "text-s13", "text-light-paper", "sm:px-24", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], [1, "mb-10", "hidden", "flex-row", "justify-center", "sm:flex"], [1, "negative-feedback"], ["id", "camera-preview"], [1, "mt-8", "hidden", "flex-row", "sm:flex"], ["classes", "secondary-button", 3, "click"], [1, "grow"], [1, "flex", "space-x-4"], ["classes", "secondary-button", 3, "click", 4, "ngIf"], ["classes", "primary-button", 3, "click", 4, "ngIf"], [1, "grow", "sm:hidden"], [1, "grid", "h-[70px]", "grid-cols-3", "sm:hidden"], [1, "flex", "justify-center"], ["class", "flex w-[70px] items-center justify-center rounded-full bg-light-paper", 3, "click", 4, "ngIf"], [1, "flex", "justify-end"], ["src", "/assets/img/switch-camera.svg", "class", "flex items-center px-2", 3, "click", 4, "ngIf"], [1, "mb-10", "sm:hidden"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], [3, "click"], [1, "ci-short_left", "text-light-paper"], ["classes", "primary-button", 3, "click"], [1, "flex", "w-[70px]", "items-center", "justify-center", "rounded-full", "bg-light-paper", 3, "click"], [1, "h-[56px]", "w-[56px]", "rounded-full", "border-2"], ["src", "/assets/img/switch-camera.svg", 1, "flex", "items-center", "px-2", 3, "click"]], template: function FrontComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, FrontComponent_ng_template_0_Template, 33, 13, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgClass, _angular_common__WEBPACK_IMPORTED_MODULE_5__.NgIf, angular_svg_icon__WEBPACK_IMPORTED_MODULE_6__.SvgIconComponent, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJmcm9udC5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 9853:
/*!*************************************************************!*\
  !*** ./apps/mobile/src/app/document/info/info.component.ts ***!
  \*************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InfoComponent": () => (/* binding */ InfoComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ngneat/transloco */ 3091);









function InfoComponent_ng_template_0_p_13_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "p", 26);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r2.documentRole + ".info.listItem1a"), " ");
} }
const _c0 = function (a0) { return [a0]; };
function InfoComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "svg-icon", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "div", 7)(8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](9, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](10, "div", 10)(11, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](13, InfoComponent_ng_template_0_p_13_Template, 2, 1, "p", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](14, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](15, "i", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](16, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](18, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](19, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](20, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](21);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](22, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](23, "i", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](24, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](25);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](26, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](27, "i", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](28, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](29);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](30, "div", 17)(31, "div", 18)(32, "zenid-button", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_32_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r5); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](33);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](34, "div", 20)(35, "zenid-button", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_35_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r5); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](36);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](37, "div", 22)(38, "zenid-button", 23);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_38_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r5); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r7.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](39);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](40, "p", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](41);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](42, "p", 25);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](43);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵclassMap"]("h-36 sm:h-20 w-auto");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("applyClass", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.info.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](16, _c0, ctx_r0.secondDocument ? "items-start" : "items-center"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("document." + ctx_r0.documentRole + ".info.listItem1"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.secondDocument);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("document." + ctx_r0.documentRole + ".info.listItem2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("document." + ctx_r0.documentRole + ".info.listItem3"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("document." + ctx_r0.documentRole + ".info.listItem4"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("document." + ctx_r0.documentRole + ".info.listItem5"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document.common.info.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".info.note"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("document." + ctx_r0.documentRole + ".info.note"), " ");
} }
class InfoComponent {
    constructor(route, messageService) {
        this.route = route;
        this.messageService = messageService;
        this.documentRole = this.route.snapshot.queryParams['documentRole'];
        this.secondDocument = false;
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
}
InfoComponent.ɵfac = function InfoComponent_Factory(t) { return new (t || InfoComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
InfoComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: InfoComponent, selectors: [["mobile-info"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "grow", "sm:hidden"], [1, "mb-8", "flex", "justify-center"], ["src", "/assets/img/idc.svg", 3, "applyClass"], [1, "mb-6", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-10", "grid", "gap-6", "text-left", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:grid-cols-2"], [1, "flex", "flex-row", 3, "ngClass"], [1, "ci-id_card", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], ["flex", "flex flex-col"], ["class", "text-s12 text-light-base-02 dark:text-dark-base-02", 4, "ngIf"], [1, "flex", "flex-row", "items-center"], [1, "ci-check_all_big", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-bulb", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-color", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-sun", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "click"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "click"], [1, "mt-6", "text-s10", "text-light-base-01", "dark:text-dark-base-01"], [1, "hidden", "px-10", "text-center", "text-s12", "text-light-base-01", "dark:text-dark-base-01", "sm:block"], [1, "text-s12", "text-light-base-02", "dark:text-dark-base-02"]], template: function InfoComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, InfoComponent_ng_template_0_Template, 44, 18, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_4__.NgClass, _angular_common__WEBPACK_IMPORTED_MODULE_4__.NgIf, angular_svg_icon__WEBPACK_IMPORTED_MODULE_5__.SvgIconComponent, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbmZvLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 7301:
/*!****************************************************!*\
  !*** ./apps/mobile/src/app/home/home.component.ts ***!
  \****************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "HomeComponent": () => (/* binding */ HomeComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! angular-svg-icon */ 2183);





function HomeComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "p", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](5, "p", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](7, "i", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_i_click_7_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r2.nextClicked({ feature: "settings" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](8, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](9);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](10, "p", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](12, "ul", 9)(13, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_div_click_13_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r4.nextClicked({ feature: "document", role: "Idc" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](14, "li", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](15, "svg-icon", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](16, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](18, "div", 13)(19, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](20, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_div_click_20_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r5.nextClicked({ feature: "document", role: "Drv" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](21, "li", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](22, "svg-icon", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](23, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](24);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](25, "div", 13)(26, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](27, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_div_click_27_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r6.nextClicked({ feature: "document", role: "Pas" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](28, "li", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](29, "svg-icon", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](30, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](31);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](32, "div", 13)(33, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](34, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_div_click_34_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r7.nextClicked({ feature: "document", role: "Filter" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](35, "li", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](36, "svg-icon", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](37, "p");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](38);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](39, "div", 13)(40, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](41, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](42, "a", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function HomeComponent_ng_template_0_Template_a_click_42_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r8 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r8.nextClicked({ feature: "welcome" })); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](43, "svg-icon", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.home.titleTrask"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.home.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.home.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.home.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("webDemo.home.menuItem1"));
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("webDemo.home.menuItem2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("webDemo.home.menuItem3"));
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("webDemo.home.menuItem5"));
} }
class HomeComponent {
    constructor(messageService) {
        this.messageService = messageService;
    }
    ngOnInit() { }
    nextClicked(eventDetail) {
        this.messageService.sendNextPressed(eventDetail);
    }
}
HomeComponent.ɵfac = function HomeComponent_Factory(t) { return new (t || HomeComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
HomeComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: HomeComponent, selectors: [["mobile-home"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "text-left"], [1, "relative", "mb-4", "flex", "items-center", "justify-start"], [1, "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:hidden"], [1, "left-1/2", "hidden", "-translate-x-1/2", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:absolute", "sm:block"], [1, "ci-settings", "ml-auto", "cursor-pointer", "text-s22", "text-light-base-00", "dark:text-dark-base-00", 3, "click"], [1, "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:hidden"], [1, "mb-4", "pr-10", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:px-20", "sm:text-center"], [1, "divide-y", "divide-light-gray-01", "text-left", "text-s15", "text-light-base-01", "dark:divide-dark-gray-01", "dark:text-dark-base-01"], [1, "hover:cursor-pointer", 3, "click"], [1, "flex", "flex-row", "items-center", "space-x-4", "py-6"], ["src", "/assets/img/type_document_1.svg"], [1, "grow"], [1, "ci-chevron_right", "text-s22", "text-light-base-00", "dark:text-dark-base-00"], ["src", "/assets/img/type_document_2.svg"], ["src", "/assets/img/type_document_3.svg"], ["src", "/assets/img/type_document_5.svg"], [1, "flex", "justify-center", "sm:hidden", 3, "click"], ["src", "/assets/img/app_logo.svg"]], template: function HomeComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](0, HomeComponent_ng_template_0_Template, 44, 8, "ng-template", 0);
    } }, dependencies: [_ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TranslocoDirective, angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__.SvgIconComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJob21lLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 4185:
/*!***********************************************************************!*\
  !*** ./apps/mobile/src/app/liveness-check/camera/camera.component.ts ***!
  \***********************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CameraComponent": () => (/* binding */ CameraComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);







function CameraComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "a", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](5, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](6, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](9, "div", 9)(10, "div", 10)(11, "zenid-button", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](13, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : "NoFaceFound")), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.camera.backButton"), " ");
} }
class CameraComponent {
    constructor(route, messageService) {
        this.route = route;
        this.messageService = messageService;
        this.feedback = this.route.snapshot.queryParams['feedback'];
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
}
CameraComponent.ɵfac = function CameraComponent_Factory(t) { return new (t || CameraComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
CameraComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: CameraComponent, selectors: [["mobile-camera"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "bg-opacity-0", "dark:bg-opacity-0", "sm:bg-opacity-100", "dark:sm:bg-opacity-100"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], ["routerLink", "../info"], [1, "ci-short_left", "text-light-paper"], [1, "grow", "sm:hidden"], [1, "mb-4", "text-s22", "font-bold", "text-light-paper", "sm:text-s17", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], ["id", "camera-preview"], [1, "mt-8", "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", "routerLink", "../info"], [1, "flex", "basis-1/2", "justify-end"]], template: function CameraComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, CameraComponent_ng_template_0_Template, 14, 2, "ng-template", 0);
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_3__.RouterLink, _angular_router__WEBPACK_IMPORTED_MODULE_3__.RouterLinkWithHref, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjYW1lcmEuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 6685:
/*!*******************************************************************!*\
  !*** ./apps/mobile/src/app/liveness-check/info/info.component.ts ***!
  \*******************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InfoComponent": () => (/* binding */ InfoComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);






const _c0 = function (a0) { return { number: a0 }; };
function InfoComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "svg-icon", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "div", 7)(8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](9, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](10, "span");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](12, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](13, "i", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](14, "span");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](16, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](17, "i", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](18, "span");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](20, "div", 12)(21, "div", 13)(22, "zenid-button", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_22_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](23);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](24, "div", 15)(25, "zenid-button", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_25_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](26);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](27, "div", 17)(28, "zenid-button", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_28_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r5.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](29);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](30, "p", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](31);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](32, "p", 20);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](33);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵclassMap"]("h-36 sm:h-20 w-auto");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("applyClass", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("livenessCheck.info.listItem1", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](12, _c0, ctx_r0.legacy ? 2 : 5)));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("livenessCheck.info.listItem2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("livenessCheck.info.listItem3"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.note"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("livenessCheck.info.note"), " ");
} }
class InfoComponent {
    constructor(messageService) {
        this.messageService = messageService;
        this.legacy = true;
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
}
InfoComponent.ɵfac = function InfoComponent_Factory(t) { return new (t || InfoComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
InfoComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: InfoComponent, selectors: [["mobile-info"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "grow", "sm:hidden"], [1, "mb-8", "flex", "justify-center"], ["src", "/assets/img/liveness.svg", 3, "applyClass"], [1, "mb-6", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-10", "grid", "gap-6", "text-left", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:grid-cols-2"], [1, "flex", "flex-row", "items-center"], [1, "ci-check_all_big", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-happy", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-list_ul", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "click"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "click"], [1, "mt-6", "text-s10", "text-light-base-01", "dark:text-dark-base-01"], [1, "hidden", "px-10", "text-center", "text-s12", "text-light-base-01", "dark:text-dark-base-01", "sm:block"]], template: function InfoComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, InfoComponent_ng_template_0_Template, 34, 14, "ng-template", 0);
    } }, dependencies: [angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__.SvgIconComponent, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbmZvLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 2319:
/*!************************************************************************!*\
  !*** ./apps/mobile/src/app/liveness-check/liveness-check.component.ts ***!
  \************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "LivenessCheckComponent": () => (/* binding */ LivenessCheckComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ 124);


class LivenessCheckComponent {
    constructor() { }
    ngOnInit() { }
}
LivenessCheckComponent.ɵfac = function LivenessCheckComponent_Factory(t) { return new (t || LivenessCheckComponent)(); };
LivenessCheckComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: LivenessCheckComponent, selectors: [["mobile-liveness-check"]], decls: 1, vars: 0, template: function LivenessCheckComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "router-outlet");
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_1__.RouterOutlet], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJsaXZlbmVzcy1jaGVjay5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 949:
/*!*********************************************************************!*\
  !*** ./apps/mobile/src/app/liveness-check/liveness-check.module.ts ***!
  \*********************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "LivenessCheckModule": () => (/* binding */ LivenessCheckModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _liveness_check_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./liveness-check.component */ 2319);
/* harmony import */ var _info_info_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./info/info.component */ 6685);
/* harmony import */ var _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./camera/camera.component */ 4185);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _zenid_ui__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @zenid/ui */ 9142);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/core */ 2560);











const routes = [
    {
        path: 'liveness-check',
        component: _liveness_check_component__WEBPACK_IMPORTED_MODULE_0__.LivenessCheckComponent,
        children: [
            {
                path: '',
                redirectTo: 'info',
                pathMatch: 'full'
            },
            {
                path: 'info',
                component: _info_info_component__WEBPACK_IMPORTED_MODULE_1__.InfoComponent
            },
            {
                path: 'camera',
                component: _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__.CameraComponent
            }
        ]
    }
];
class LivenessCheckModule {
}
LivenessCheckModule.ɵfac = function LivenessCheckModule_Factory(t) { return new (t || LivenessCheckModule)(); };
LivenessCheckModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵdefineNgModule"]({ type: LivenessCheckModule });
LivenessCheckModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵdefineInjector"]({ imports: [_angular_common__WEBPACK_IMPORTED_MODULE_6__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_7__.RouterModule.forChild(routes), angular_svg_icon__WEBPACK_IMPORTED_MODULE_8__.AngularSvgIconModule.forRoot(), _zenid_ui__WEBPACK_IMPORTED_MODULE_3__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_4__.UtilModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵsetNgModuleScope"](LivenessCheckModule, { declarations: [_liveness_check_component__WEBPACK_IMPORTED_MODULE_0__.LivenessCheckComponent, _info_info_component__WEBPACK_IMPORTED_MODULE_1__.InfoComponent, _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__.CameraComponent], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_6__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_7__.RouterModule, angular_svg_icon__WEBPACK_IMPORTED_MODULE_8__.AngularSvgIconModule, _zenid_ui__WEBPACK_IMPORTED_MODULE_3__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_4__.UtilModule] }); })();


/***/ }),

/***/ 7277:
/*!**********************************************************!*\
  !*** ./apps/mobile/src/app/loading/loading.component.ts ***!
  \**********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "LoadingComponent": () => (/* binding */ LoadingComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @ngneat/transloco */ 3091);





function LoadingComponent_ng_template_0_lottie_player_3_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](0, "lottie-player", 6);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function LoadingComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](3, LoadingComponent_ng_template_0_lottie_player_3_Template, 1, 1, "lottie-player", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](6, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("loading.title"));
} }
class LoadingComponent {
    constructor(uiService) {
        this.uiService = uiService;
        this.animationSrc = JSON.stringify(this.uiService.animations['loading']);
    }
}
LoadingComponent.ɵfac = function LoadingComponent_Factory(t) { return new (t || LoadingComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService)); };
LoadingComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: LoadingComponent, selectors: [["mobile-loading"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "grow"], ["autoplay", "", "loop", "", "mode", "normal", "class", "h-fit sm:h-40", 3, "src", 4, "ngIf"], [1, "text-center", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:mb-20"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"]], template: function LoadingComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](0, LoadingComponent_ng_template_0_Template, 7, 2, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_2__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJsb2FkaW5nLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 296:
/*!**********************************************************!*\
  !*** ./apps/mobile/src/app/results/results.component.ts ***!
  \**********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ResultsComponent": () => (/* binding */ ResultsComponent)
/* harmony export */ });
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! rxjs */ 9295);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);








function ResultsComponent_ng_template_0_img_4_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](0, "img", 18);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpropertyInterpolate2"]("src", "https://mobile.frauds.zenid.cz/History/Image/", ctx_r2.selfieImgHash, "?width=500&api_key=", ctx_r2.apiKey, "", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeUrl"]);
} }
const _c0 = function (a0) { return { "bg-light-red-00 dark:bg-dark-red-00": a0 }; };
function ResultsComponent_ng_template_0_ng_container_13_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementContainerStart"](0);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](1, "div", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](2, "div", 20);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementContainerEnd"]();
} if (rf & 2) {
    const ctx_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](3, _c0, ctx_r3.verifiedError.document));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](5, _c0, ctx_r3.verifiedError.selfie || ctx_r3.verifiedError.liveness));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", ctx_r3.verifiedError.selfie || ctx_r3.verifiedError.liveness ? "ci-error_outline" : "ci-check");
} }
function ResultsComponent_ng_template_0_div_16_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵattribute"]("selfieError", ctx_r4.text.selfieError);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r4.text.selfie, " ");
} }
function ResultsComponent_ng_template_0_a_20_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "a", 22);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function ResultsComponent_ng_template_0_a_20_Template_a_click_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.results.success.backButton"), " ");
} }
const _c1 = function (a0) { return { "-mr-2": a0 }; };
const _c2 = function (a0) { return { "mb-6": a0 }; };
function ResultsComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r10 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](3, "img", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](4, ResultsComponent_ng_template_0_img_4_Template, 1, 2, "img", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](9, "div", 8)(10, "div", 9)(11, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](12, "i", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](13, ResultsComponent_ng_template_0_ng_container_13_Template, 5, 7, "ng-container", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](14, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](16, ResultsComponent_ng_template_0_div_16_Template, 2, 2, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](17, "div", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](18, "zenid-button", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function ResultsComponent_ng_template_0_Template_zenid_button_click_18_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r10); const ctx_r9 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r9.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](20, ResultsComponent_ng_template_0_a_20_Template, 2, 1, "a", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpropertyInterpolate2"]("src", "https://mobile.frauds.zenid.cz/History/Image/", ctx_r0.documentImgHash, "?width=500&api_key=", ctx_r0.apiKey, "", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](17, _c1, ctx_r0.selfieImgHash));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.selfieImgHash);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r0.text.title, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r0.text.desc, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", (ctx_r0.selfieVerification === "none" ? "grid-rows-1" : "grid-rows-2") + " " + (ctx_r0.verifiedError.selfie || ctx_r0.verifiedError.liveness ? "mb-14" : "mb-8"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](19, _c0, ctx_r0.verifiedError.document));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", ctx_r0.verifiedError.document ? "ci-error_outline" : "ci-check");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.selfieVerification !== "none");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵattribute"]("idError", ctx_r0.text.idError);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r0.text.id, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.selfieVerification !== "none");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵpureFunction1"](21, _c2, ctx_r0.verifiedError.any))("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r0.text.submitButton, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx_r0.verifiedError.any);
} }
class ResultsComponent {
    constructor(messageService, translocoService) {
        this.messageService = messageService;
        this.translocoService = translocoService;
        this.verifiedError = {
            any: false
        };
        this.text = {};
        this.apiKey = this.messageService.dataToSend.previousEvent?.apiKey;
        this.translocoService
            .selectTranslation('web-demo')
            .pipe((0,rxjs__WEBPACK_IMPORTED_MODULE_3__.take)(1))
            .subscribe(() => {
            this.result = this.messageService.dataToSend.previousEvent?.investigateResponse;
            if (this.messageService.dataToSend.previousEvent?.data?.selfieVerification) {
                this.selfieVerification = this.messageService.dataToSend.previousEvent.data.selfieVerification;
            }
            else {
                this.selfieVerification = 'none';
            }
            this.result?.Rank?.Samples?.forEach((sample) => {
                if (sample.Rank === 'F' && this.verifiedError.any === false) {
                    this.verifiedError.any = true;
                }
                switch (sample.SampleType) {
                    case 'DocumentPicture':
                        if (sample.Rank === 'F' && !this.verifiedError.document) {
                            this.verifiedError.document = true;
                        }
                        break;
                    case 'Selfie':
                        if (sample.Rank === 'F' && !this.verifiedError.selfie) {
                            this.verifiedError.selfie = true;
                        }
                        break;
                    case 'SelfieVideo':
                        if (sample.Rank === 'F' && !this.verifiedError.liveness) {
                            this.verifiedError.liveness = true;
                        }
                        break;
                }
            });
            this.uniqueError = this.detectUniqueError();
            const firstName = this.result?.MinedData?.FirstName?.Text;
            const lastName = this.result?.MinedData?.LastName?.Text;
            const namesReaded = !!(firstName && lastName);
            this.text.title =
                namesReaded && !this.verifiedError.document
                    ? this.translocoService.translate('webDemo.results.success.title', {
                        fullName: `${firstName} ${lastName}`
                    })
                    : this.translocoService.translate('webDemo.results.error.title');
            this.text.desc = this.translocoService.translate(!this.verifiedError.any ? 'webDemo.results.success.desc' : 'webDemo.results.error.desc');
            if (this.verifiedError.document) {
                this.text.id = this.translocoService.translate('webDemo.results.error.document');
            }
            else {
                let documentNumber;
                if (this.result?.MinedData?.IdcardNumber?.Text) {
                    documentNumber = this.result.MinedData.IdcardNumber.Text;
                }
                if (this.result?.MinedData?.DrivinglicenseNumber?.Text) {
                    documentNumber = this.result.MinedData.DrivinglicenseNumber.Text;
                }
                if (this.result?.MinedData?.PassportNumber?.Text) {
                    documentNumber = this.result.MinedData.PassportNumber.Text;
                }
                const documentTexts = this.translocoService.translate([
                    'webDemo.results.success.document',
                    'webDemo.results.success.numberSign'
                ]);
                this.text.id = documentNumber
                    ? `${documentTexts[0]} ${documentTexts[1]}${documentNumber}`
                    : documentTexts[0];
            }
            this.text.selfie = this.translocoService.translate(this.selfieText());
            this.text.submitButton = this.translocoService.translate(this.submitButtonErrorText());
            if (this.verifiedError.document) {
                this.text.idError = this.translocoService.translate('webDemo.results.error.idDescription');
            }
            if (this.verifiedError.selfie) {
                this.text.selfieError = this.translocoService.translate('webDemo.results.error.selfieDescription');
            }
            if (this.verifiedError.liveness) {
                this.text.selfieError = this.translocoService.translate('webDemo.results.error.livenessDescription');
            }
        });
    }
    get documentImgHash() {
        return this.result?.MinedData?.Photo?.ImageData?.ImageHash?.AsText;
    }
    get selfieImgHash() {
        return this.result?.Rank?.Samples?.find((sample) => sample.SampleType === 'Selfie')?.SampleID;
    }
    detectUniqueError() {
        const errors = [this.verifiedError.document, this.verifiedError.selfie, this.verifiedError.liveness];
        const isUnique = errors.filter((error) => error === true).length === 1;
        if (isUnique) {
            switch (true) {
                case errors[0]:
                    return 'document';
                case errors[1]:
                    return 'selfie';
                case errors[2]:
                    return 'liveness';
            }
        }
        return 'any';
    }
    submitButtonErrorText() {
        if (this.verifiedError.any) {
            switch (this.uniqueError) {
                case 'document':
                    return 'webDemo.results.error.submitButton.id';
                case 'selfie':
                    return 'webDemo.results.error.submitButton.selfie';
                case 'liveness':
                    return 'webDemo.results.error.submitButton.liveness';
                default:
                    return 'webDemo.results.error.submitButton.failed';
            }
        }
        return 'webDemo.results.success.submitButton';
    }
    selfieText() {
        const verification = this.selfieVerification;
        const error = this.verifiedError.selfie;
        if (verification === 'selfie') {
            return error ? 'webDemo.results.error.selfie' : 'webDemo.results.success.selfie';
        }
        return error ? 'webDemo.results.error.liveness' : 'webDemo.results.success.liveness';
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
}
ResultsComponent.ɵfac = function ResultsComponent_Factory(t) { return new (t || ResultsComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoService)); };
ResultsComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: ResultsComponent, selectors: [["mobile-results"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "mb-8", "flex", "justify-center"], [1, "h-[88px]", "w-[88px]", "rounded-full", "object-cover", 3, "src", "ngClass"], ["class", "-ml-2 h-[88px] w-[88px] rounded-full object-cover", 3, "src", 4, "ngIf"], [1, "mb-2", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-8", "text-s13", "text-light-base-02", "dark:text-dark-base-02"], [1, "grid", "grid-flow-col", "gap-x-4", "gap-y-14", 3, "ngClass"], [1, "row-span-2", "flex", "flex-col", "items-end"], [1, "flex", "h-6", "w-6", "items-center", "justify-center", "rounded-full", "bg-light-green-00", "dark:bg-dark-green-00", 3, "ngClass"], [1, "text-light-base-contrast", "dark:text-dark-base-contrast", 3, "ngClass"], [4, "ngIf"], [1, "relative", "text-left", "text-s15", "text-light-base-01", "after:absolute", "after:left-0", "after:top-[calc(100%+9px)]", "after:text-s12", "after:text-light-base-02", "after:content-[attr(idError)]", "dark:text-dark-base-01", "dark:after:text-dark-base-02"], ["class", "relative text-left text-s15 text-light-base-01 after:absolute after:left-0 after:top-[calc(100%+9px)] after:text-s12 after:text-light-base-02 after:content-[attr(selfieError)] dark:text-dark-base-01 dark:after:text-dark-base-02", 4, "ngIf"], [1, "grow"], ["classes", "primary-button w-full", 3, "ngClass", "withIcon", "click"], ["class", "text-s15 text-light-base-00 hover:text-light-base-03 dark:text-dark-base-00 dark:hover:text-dark-base-03", 3, "click", 4, "ngIf"], [1, "-ml-2", "h-[88px]", "w-[88px]", "rounded-full", "object-cover", 3, "src"], [1, "flex", "w-6", "grow", "flex-row", "justify-center"], [1, "h-full", "w-[1px]", "bg-light-green-00", "dark:bg-dark-green-00", 3, "ngClass"], [1, "relative", "text-left", "text-s15", "text-light-base-01", "after:absolute", "after:left-0", "after:top-[calc(100%+9px)]", "after:text-s12", "after:text-light-base-02", "after:content-[attr(selfieError)]", "dark:text-dark-base-01", "dark:after:text-dark-base-02"], [1, "text-s15", "text-light-base-00", "hover:text-light-base-03", "dark:text-dark-base-00", "dark:hover:text-dark-base-03", 3, "click"]], template: function ResultsComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, ResultsComponent_ng_template_0_Template, 21, 23, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgClass, _angular_common__WEBPACK_IMPORTED_MODULE_5__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJyZXN1bHRzLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 7629:
/*!****************************************************!*\
  !*** ./apps/mobile/src/app/scan/scan.component.ts ***!
  \****************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ScanComponent": () => (/* binding */ ScanComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @ngneat/transloco */ 3091);




function ScanComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](2, "div", 3)(3, "div", 4)(4, "a", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("click", function ScanComponent_ng_template_0_Template_a_click_4_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](5, "i", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](6, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](7, "Scan QR code");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](8, "p", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](9, "Log in by scanning provided QR code");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()()();
} }
class ScanComponent {
    constructor(messageService) {
        this.messageService = messageService;
    }
    ngOnInit() { }
    backClicked() {
        this.messageService.sendBackPressed();
    }
}
ScanComponent.ɵfac = function ScanComponent_Factory(t) { return new (t || ScanComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
ScanComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: ScanComponent, selectors: [["mobile-scan"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "absolute", "left-0", "top-0", "z-[-1]", "h-screen", "w-full", "after:absolute", "after:inset-x-[15vw]", "after:top-[calc((100%_-_calc(0.7_*_100vw))_*_0.5)]", "after:h-[calc(0.7_*_100vw)]", "after:rounded-md", "after:border-2", "after:border-light-paper", "after:shadow-viewport", "sm:hidden"], [1, "main-container-mobile", "bg-opacity-0", "dark:bg-opacity-0", "sm:bg-opacity-100", "dark:sm:bg-opacity-100"], [1, "mb-6", "ml-1", "text-left"], [3, "click"], [1, "ci-short_left", "text-light-paper"], [1, "mb-4", "text-center", "text-s22", "font-bold", "text-light-paper", "sm:hidden"], [1, "mb-6", "text-center", "text-s13", "text-light-paper", "sm:hidden"]], template: function ScanComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](0, ScanComponent_ng_template_0_Template, 10, 0, "ng-template", 0);
    } }, dependencies: [_ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzY2FuLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 8184:
/*!***************************************************************!*\
  !*** ./apps/mobile/src/app/selfie/camera/camera.component.ts ***!
  \***************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CameraComponent": () => (/* binding */ CameraComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);







function CameraComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "a", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CameraComponent_ng_template_0_Template_a_click_3_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](9, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](10, "div", 9)(11, "div", 10)(12, "zenid-button", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CameraComponent_ng_template_0_Template_zenid_button_click_12_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](14, "div", 12)(15, "zenid-button", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](17, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](18, "div", 15)(19, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](20, "div", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.camera.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("feedback." + (ctx_r0.feedback ? ctx_r0.feedback : "NoFaceFound")), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.camera.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.camera.nextButton"), " ");
} }
class CameraComponent {
    constructor(route, messageService) {
        this.route = route;
        this.messageService = messageService;
        this.feedback = this.route.snapshot.queryParams['feedback'];
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
}
CameraComponent.ɵfac = function CameraComponent_Factory(t) { return new (t || CameraComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
CameraComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: CameraComponent, selectors: [["mobile-camera"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "bg-opacity-0", "dark:bg-opacity-0", "sm:bg-opacity-100", "dark:sm:bg-opacity-100"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], [3, "click"], [1, "ci-short_left", "text-light-paper"], [1, "mb-4", "text-s22", "font-bold", "text-light-paper", "sm:text-s17", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], [1, "mb-6", "text-s13", "text-light-paper", "sm:px-24", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], ["id", "camera-preview"], [1, "mt-8", "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button"], [1, "grow", "sm:hidden"], [1, "flex", "flex-row", "justify-center", "sm:hidden"], [1, "flex", "h-[70px]", "w-[70px]", "items-center", "justify-center", "rounded-full", "bg-light-paper"], [1, "h-[56px]", "w-[56px]", "rounded-full", "border-2"]], template: function CameraComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, CameraComponent_ng_template_0_Template, 21, 4, "ng-template", 0);
    } }, dependencies: [_libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjYW1lcmEuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 2019:
/*!*************************************************************!*\
  !*** ./apps/mobile/src/app/selfie/check/check.component.ts ***!
  \*************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CheckComponent": () => (/* binding */ CheckComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/platform-browser */ 4497);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);








const _c0 = ["snapshotArea"];
function CheckComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "a", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CheckComponent_ng_template_0_Template_a_click_3_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r3.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "i", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "p", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](9, "div", 8, 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](11, "img", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](12, "div", 11)(13, "div", 12)(14, "zenid-button", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CheckComponent_ng_template_0_Template_zenid_button_click_14_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r5.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](16, "div", 14)(17, "zenid-button", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CheckComponent_ng_template_0_Template_zenid_button_click_17_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](19, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](20, "div", 17)(21, "zenid-button", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CheckComponent_ng_template_0_Template_zenid_button_click_21_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r7.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](22);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](23, "p", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function CheckComponent_ng_template_0_Template_p_click_23_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r8 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r8.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](24);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("src", ctx_r0.imagePath, _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.check.backButton"), " ");
} }
class CheckComponent {
    constructor(messageService, sanitizer) {
        this.messageService = messageService;
        this.sanitizer = sanitizer;
        this.imagePath = this.sanitizer.bypassSecurityTrustResourceUrl('data:image/jpg;base64,' + this.messageService.dataToSend.previousEvent?.base64);
    }
    set snapshotpreview(el) {
        if (el)
            this.setEllipse(el);
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
    setEllipse(snapshotpreview) {
        const snapshot = snapshotpreview.nativeElement;
        const image = snapshotpreview.nativeElement.getElementsByTagName('img')[0];
        let canvasWidth = snapshot.offsetWidth || parseInt(image.style.width);
        let canvasHeight = snapshot.offsetHeight || parseInt(image.style.height);
        // Height of all elements, their vertical margins and container padding. If template is changed, manual recalculation is necessary.
        const allElementVerticalHeight = 260;
        let insufficientDisplay = false;
        let previewVerticalMargin = 0;
        canvasWidth = window.innerWidth;
        canvasHeight = window.innerHeight;
        insufficientDisplay = canvasHeight < canvasWidth + allElementVerticalHeight;
        if (insufficientDisplay) {
            canvasWidth = canvasHeight - allElementVerticalHeight;
        }
        else {
            previewVerticalMargin = Math.floor((canvasHeight - allElementVerticalHeight - canvasWidth) / 2);
        }
        const ellipseHeight = Math.round(Math.min(canvasWidth, canvasHeight * 0.8));
        const ellipseWidth = Math.round(ellipseHeight * 0.75);
        const overlayTopToDocument = Math.round(snapshot.getBoundingClientRect().y + window.scrollY);
        image.removeAttribute('style');
        const overlay = document.createElement('div');
        overlay.id = 'selfie-overlay';
        snapshot.style.cssText = `
            --ellipseWidth: ${ellipseWidth}px;
            --ellipseHeight: ${ellipseHeight}px;
            --elipsisTopToParrent: ${Math.round(canvasHeight - ellipseHeight) / 2}px;
            --canvasWidth: ${canvasWidth}px;
            --canvasHeight: ${canvasHeight}px;
            --overlayTopToDocument: ${overlayTopToDocument}px;
            `;
        if (previewVerticalMargin) {
            snapshot.style.cssText += `
            margin: ${previewVerticalMargin}px auto;
            `;
        }
        snapshot.appendChild(overlay);
    }
}
CheckComponent.ɵfac = function CheckComponent_Factory(t) { return new (t || CheckComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__.DomSanitizer)); };
CheckComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: CheckComponent, selectors: [["mobile-check"]], viewQuery: function CheckComponent_Query(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵviewQuery"](_c0, 5);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵloadQuery"]()) && (ctx.snapshotpreview = _t.first);
    } }, decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "mb-4", "ml-1", "text-left", "sm:hidden"], [3, "click"], [1, "ci-short_left", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:text-s17"], [1, "mb-6", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:px-24"], ["id", "selfie-preview"], ["snapshotArea", ""], [3, "src"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "withIcon", "click"], [1, "grow", "sm:hidden"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "withIcon", "click"], [1, "mt-6", "text-s15", "text-light-base-00", "dark:text-dark-base-00", 3, "click"]], template: function CheckComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, CheckComponent_ng_template_0_Template, 25, 9, "ng-template", 0);
    } }, dependencies: [_libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjaGVjay5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 4651:
/*!***********************************************************!*\
  !*** ./apps/mobile/src/app/selfie/info/info.component.ts ***!
  \***********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InfoComponent": () => (/* binding */ InfoComponent)
/* harmony export */ });
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);






function InfoComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](4, "svg-icon", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](7, "div", 7)(8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](9, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](10, "span");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](12, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](13, "i", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](14, "span");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](16, "div", 11)(17, "div", 12)(18, "zenid-button", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_18_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r2.backClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](20, "div", 14)(21, "zenid-button", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_21_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](22);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](23, "div", 16)(24, "zenid-button", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function InfoComponent_ng_template_0_Template_zenid_button_click_24_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r5.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](25);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](26, "p", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](27);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](28, "p", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](29);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵclassMap"]("h-36 sm:h-20 w-auto");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("applyClass", true);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("selfie.info.listItem1"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](t_r1("selfie.info.listItem2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.backButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.nextButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.note"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", t_r1("selfie.info.note"), " ");
} }
class InfoComponent {
    constructor(messageService) {
        this.messageService = messageService;
    }
    backClicked() {
        this.messageService.sendBackPressed();
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
}
InfoComponent.ɵfac = function InfoComponent_Factory(t) { return new (t || InfoComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_0__.MessageService)); };
InfoComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: InfoComponent, selectors: [["mobile-info"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "grow", "sm:hidden"], [1, "mb-8", "flex", "justify-center"], ["src", "/assets/img/liveness.svg", 3, "applyClass"], [1, "mb-6", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-10", "grid", "gap-6", "text-left", "text-s13", "text-light-base-01", "dark:text-dark-base-01", "sm:grid-cols-2"], [1, "flex", "flex-row", "items-center"], [1, "ci-id_card", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "ci-bulb", "mx-3", "text-light-base-00", "dark:text-dark-base-00"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], ["classes", "secondary-button", 3, "click"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "click"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "click"], [1, "mt-6", "text-s10", "text-light-base-01", "dark:text-dark-base-01"], [1, "hidden", "px-10", "text-center", "text-s12", "text-light-base-01", "dark:text-dark-base-01", "sm:block"]], template: function InfoComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, InfoComponent_ng_template_0_Template, 30, 11, "ng-template", 0);
    } }, dependencies: [angular_svg_icon__WEBPACK_IMPORTED_MODULE_3__.SvgIconComponent, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbmZvLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 1193:
/*!********************************************************!*\
  !*** ./apps/mobile/src/app/selfie/selfie.component.ts ***!
  \********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SelfieComponent": () => (/* binding */ SelfieComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ 124);


class SelfieComponent {
    constructor() { }
    ngOnInit() { }
}
SelfieComponent.ɵfac = function SelfieComponent_Factory(t) { return new (t || SelfieComponent)(); };
SelfieComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: SelfieComponent, selectors: [["mobile-selfie"]], decls: 1, vars: 0, template: function SelfieComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "router-outlet");
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_1__.RouterOutlet], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzZWxmaWUuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 5368:
/*!*****************************************************!*\
  !*** ./apps/mobile/src/app/selfie/selfie.module.ts ***!
  \*****************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SelfieModule": () => (/* binding */ SelfieModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _selfie_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./selfie.component */ 1193);
/* harmony import */ var _info_info_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./info/info.component */ 4651);
/* harmony import */ var _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./camera/camera.component */ 8184);
/* harmony import */ var _check_check_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./check/check.component */ 2019);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var angular_svg_icon__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! angular-svg-icon */ 2183);
/* harmony import */ var _zenid_ui__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @zenid/ui */ 9142);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/core */ 2560);












const routes = [
    {
        path: 'selfie',
        component: _selfie_component__WEBPACK_IMPORTED_MODULE_0__.SelfieComponent,
        children: [
            {
                path: '',
                redirectTo: 'info',
                pathMatch: 'full'
            },
            {
                path: 'info',
                component: _info_info_component__WEBPACK_IMPORTED_MODULE_1__.InfoComponent
            },
            {
                path: 'camera',
                component: _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__.CameraComponent
            },
            {
                path: 'check',
                component: _check_check_component__WEBPACK_IMPORTED_MODULE_3__.CheckComponent
            }
        ]
    }
];
class SelfieModule {
}
SelfieModule.ɵfac = function SelfieModule_Factory(t) { return new (t || SelfieModule)(); };
SelfieModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵdefineNgModule"]({ type: SelfieModule });
SelfieModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵdefineInjector"]({ imports: [_angular_common__WEBPACK_IMPORTED_MODULE_7__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_8__.RouterModule.forChild(routes), angular_svg_icon__WEBPACK_IMPORTED_MODULE_9__.AngularSvgIconModule.forRoot(), _zenid_ui__WEBPACK_IMPORTED_MODULE_4__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_5__.UtilModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵsetNgModuleScope"](SelfieModule, { declarations: [_selfie_component__WEBPACK_IMPORTED_MODULE_0__.SelfieComponent, _info_info_component__WEBPACK_IMPORTED_MODULE_1__.InfoComponent, _camera_camera_component__WEBPACK_IMPORTED_MODULE_2__.CameraComponent, _check_check_component__WEBPACK_IMPORTED_MODULE_3__.CheckComponent], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_7__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_8__.RouterModule, angular_svg_icon__WEBPACK_IMPORTED_MODULE_9__.AngularSvgIconModule, _zenid_ui__WEBPACK_IMPORTED_MODULE_4__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_5__.UtilModule] }); })();


/***/ }),

/***/ 7357:
/*!************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/common/header/header.component.ts ***!
  \************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "HeaderComponent": () => (/* binding */ HeaderComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ 4666);



function HeaderComponent_div_5_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 5)(1, "i", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function HeaderComponent_div_5_Template_i_click_1_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵresetView"](ctx_r2.submit.emit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]()();
} }
function HeaderComponent_div_6_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 5)(1, "i", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function HeaderComponent_div_6_Template_i_click_1_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r5); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵresetView"](ctx_r4.add.emit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]()();
} }
class HeaderComponent {
    constructor() {
        this.back = new _angular_core__WEBPACK_IMPORTED_MODULE_0__.EventEmitter();
        this.add = new _angular_core__WEBPACK_IMPORTED_MODULE_0__.EventEmitter();
        this.submit = new _angular_core__WEBPACK_IMPORTED_MODULE_0__.EventEmitter();
    }
    ngOnInit() { }
}
HeaderComponent.ɵfac = function HeaderComponent_Factory(t) { return new (t || HeaderComponent)(); };
HeaderComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: HeaderComponent, selectors: [["mobile-header"]], inputs: { title: "title" }, outputs: { back: "back", add: "add", submit: "submit" }, decls: 7, vars: 3, consts: [[1, "grid", "w-full", "grid-cols-10", "content-center", "items-center"], [1, "flex", "justify-start"], [1, "ci-short_left", "text-s22", "text-light-base-01", "dark:text-dark-base-01", 3, "click"], [1, "col-span-8", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], ["class", "flex justify-end", 4, "ngIf"], [1, "flex", "justify-end"], [1, "ci-check_big", "text-s22", "text-light-base-00", "dark:text-dark-base-00", 3, "click"], [1, "ci-plus", "text-s22", "text-light-base-00", "dark:text-dark-base-00", 3, "click"]], template: function HeaderComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0)(1, "div", 1)(2, "i", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function HeaderComponent_Template_i_click_2_listener() { return ctx.back.emit(); });
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]()();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "p", 3);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](4);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](5, HeaderComponent_div_5_Template, 2, 0, "div", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](6, HeaderComponent_div_6_Template, 2, 0, "div", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](4);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" ", ctx.title, " ");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.submit.observers.length > 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.add.observers.length > 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_1__.NgIf], styles: ["[_nghost-%COMP%] {\n    position: sticky;\n    top: 0px;\n    margin-left: -1rem;\n    margin-right: -1rem;\n    display: flex;\n    border-bottom-width: 1px;\n    border-bottom-color: var(--secondary-color);\n    padding: 1rem;\n    --tw-backdrop-blur: blur(12px);\n    -webkit-backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);\n            backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia)\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImhlYWRlci5jb21wb25lbnQuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFDSTtJQUFBLGdCQUFBO0lBQUEsUUFBQTtJQUFBLGtCQUFBO0lBQUEsbUJBQUE7SUFBQSxhQUFBO0lBQUEsd0JBQUE7SUFBQSwyQ0FBQTtJQUFBLGFBQUE7SUFBQSw4QkFBQTtJQUFBLCtRQUFBO1lBQUE7QUFBQSIsImZpbGUiOiJoZWFkZXIuY29tcG9uZW50LnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyI6aG9zdCB7XG4gICAgQGFwcGx5IHN0aWNreSB0b3AtMCAtbXgtNCBmbGV4IGJvcmRlci1iIGJvcmRlci1iLWxpZ2h0LWdyYXktMDEgcC00IGJhY2tkcm9wLWJsdXItbWQ7XG59XG4iXX0= */"] });


/***/ }),

/***/ 2733:
/*!*******************************************************************!*\
  !*** ./apps/mobile/src/app/settings/country/country.component.ts ***!
  \*******************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CountryComponent": () => (/* binding */ CountryComponent)
/* harmony export */ });
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../common/header/header.component */ 7357);










function CountryComponent_ng_template_0_div_3_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function CountryComponent_ng_template_0_div_3_Template_div_click_0_listener() { const restoredCtx = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r5); const country_r3 = restoredCtx.$implicit; const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r4.selectCountry(country_r3)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](1, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](3, "div", 7)(4, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} if (rf & 2) {
    const country_r3 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](country_r3.displayName);
} }
function CountryComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("back", function CountryComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r6.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](3, CountryComponent_ng_template_0_div_3_Template, 5, 1, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("formGroup", ctx_r0.form);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("title", t_r1("webDemo.settings.country"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngForOf", ctx_r0.countries);
} }
class CountryComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    selectCountry(country) {
        this.form.get('country')?.setValue(country.codeString);
        this.router.navigate(['..', { relativeTo: this.route }]);
    }
    get form() {
        return this.settingsService.form;
    }
    get countries() {
        return libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__.zenidContriesFull.sort((a, b) => ('' + a.displayName).localeCompare(b.displayName));
    }
}
CountryComponent.ɵfac = function CountryComponent_Factory(t) { return new (t || CountryComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_1__.SettingsService)); };
CountryComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: CountryComponent, selectors: [["mobile-settings-country"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "h-fit", "min-h-screen", 3, "formGroup"], [3, "title", "back"], ["class", "flex flex-row items-center py-4", 3, "click", 4, "ngFor", "ngForOf"], [1, "flex", "flex-row", "items-center", "py-4", 3, "click"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"]], template: function CountryComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, CountryComponent_ng_template_0_Template, 4, 3, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgForOf, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.NgControlStatusGroup, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.FormGroupDirective, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjb3VudHJ5LmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 6941:
/*!*************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-filter/documents-filter.component.ts ***!
  \*************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DocumentsFilterComponent": () => (/* binding */ DocumentsFilterComponent)
/* harmony export */ });
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../common/header/header.component */ 7357);









function DocumentsFilterComponent_ng_template_0_div_4_div_2_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const filter_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    let tmp_0_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", (tmp_0_0 = filter_r3.get("Role")) == null ? null : tmp_0_0.value, " ");
} }
function DocumentsFilterComponent_ng_template_0_div_4_div_3_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const filter_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    let tmp_0_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", (tmp_0_0 = filter_r3.get("Country")) == null ? null : tmp_0_0.value, " ");
} }
function DocumentsFilterComponent_ng_template_0_div_4_div_4_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const filter_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]().$implicit;
    let tmp_0_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", (tmp_0_0 = filter_r3.get("Page")) == null ? null : tmp_0_0.value, " ");
} }
function DocumentsFilterComponent_ng_template_0_div_4_Template(rf, ctx) { if (rf & 1) {
    const _r12 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 6)(1, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](2, DocumentsFilterComponent_ng_template_0_div_4_div_2_Template, 2, 1, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](3, DocumentsFilterComponent_ng_template_0_div_4_div_3_Template, 2, 1, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](4, DocumentsFilterComponent_ng_template_0_div_4_div_4_Template, 2, 1, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](5, "div", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](6, "i", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function DocumentsFilterComponent_ng_template_0_div_4_Template_i_click_6_listener() { const restoredCtx = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r12); const i_r4 = restoredCtx.index; const ctx_r11 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r11.removeFilter(i_r4)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const filter_r3 = ctx.$implicit;
    let tmp_0_0;
    let tmp_1_0;
    let tmp_2_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", (tmp_0_0 = filter_r3.get("Role")) == null ? null : tmp_0_0.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", (tmp_1_0 = filter_r3.get("Country")) == null ? null : tmp_1_0.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", (tmp_2_0 = filter_r3.get("Page")) == null ? null : tmp_2_0.value);
} }
function DocumentsFilterComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r14 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("back", function DocumentsFilterComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r14); const ctx_r13 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r13.back()); })("add", function DocumentsFilterComponent_ng_template_0_Template_mobile_header_add_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r14); const ctx_r15 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r15.add()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](4, DocumentsFilterComponent_ng_template_0_div_4_Template, 7, 3, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("formGroup", ctx_r0.form);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsFilter.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngForOf", ctx_r0.documentsFilterArray.controls);
} }
class DocumentsFilterComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    add() {
        this.router.navigate(['new'], { relativeTo: this.route });
    }
    get form() {
        return this.settingsService.form;
    }
    get documentsFilterArray() {
        return this.settingsService.form.get('DocumentsFilter');
    }
    removeFilter(index) {
        this.settingsService.removeFilter(index);
    }
}
DocumentsFilterComponent.ɵfac = function DocumentsFilterComponent_Factory(t) { return new (t || DocumentsFilterComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
DocumentsFilterComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: DocumentsFilterComponent, selectors: [["mobile-documents-filter"]], decls: 2, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", 3, "formGroup"], [3, "title", "back", "add"], [1, "flex", "flex-col", "space-y-4", "py-4"], ["class", "flex flex-row items-center rounded-sm border border-light-paper dark:border-dark-paper sm:px-4 sm:hover:border-light-gray-01 sm:hover:bg-light-gray-00 dark:sm:hover:border-dark-gray-01 dark:sm:hover:bg-dark-gray-00", 4, "ngFor", "ngForOf"], [1, "flex", "flex-row", "items-center", "rounded-sm", "border", "border-light-paper", "dark:border-dark-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00"], [1, "flex", "flex-row", "space-x-4"], ["class", "w-16 rounded bg-light-action-00 px-4 py-1.5 text-s15 text-light-base-02 dark:bg-dark-action-00 dark:text-dark-base-02", 4, "ngIf"], [1, "grow"], [1, "ci-minus_circle", "peer", "cursor-pointer", "text-s22", "text-light-red-00", "dark:text-dark-red-00", 3, "click"], [1, "w-16", "rounded", "bg-light-action-00", "px-4", "py-1.5", "text-s15", "text-light-base-02", "dark:bg-dark-action-00", "dark:text-dark-base-02"]], template: function DocumentsFilterComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, DocumentsFilterComponent_ng_template_0_Template, 5, 3, "ng-template", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](1, "router-outlet");
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_4__.NgForOf, _angular_common__WEBPACK_IMPORTED_MODULE_4__.NgIf, _angular_router__WEBPACK_IMPORTED_MODULE_3__.RouterOutlet, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.NgControlStatusGroup, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.FormGroupDirective, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_1__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJkb2N1bWVudHMtZmlsdGVyLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 511:
/*!*********************************************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-filter/new-filter/new-filter-country/new-filter-country.component.ts ***!
  \*********************************************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "NewFilterCountryComponent": () => (/* binding */ NewFilterCountryComponent)
/* harmony export */ });
/* harmony import */ var apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! apps/mobile/src/app/common/services/settings.service */ 8262);
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../common/header/header.component */ 7357);









function NewFilterCountryComponent_ng_template_0_div_3_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function NewFilterCountryComponent_ng_template_0_div_3_Template_div_click_0_listener() { const restoredCtx = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r5); const country_r3 = restoredCtx.$implicit; const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r4.selectCountry(country_r3)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](1, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](3, "div", 7)(4, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} if (rf & 2) {
    const country_r3 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](country_r3.displayName);
} }
function NewFilterCountryComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("back", function NewFilterCountryComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r6.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](3, NewFilterCountryComponent_ng_template_0_div_3_Template, 5, 1, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsFilter.modal.country"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngForOf", ctx_r0.countries);
} }
class NewFilterCountryComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    selectCountry(country) {
        this.settingsService.filterForm.get('Country')?.setValue(country.codeString);
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    get countries() {
        return libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__.zenidContriesFull.sort((a, b) => ('' + a.displayName).localeCompare(b.displayName));
    }
}
NewFilterCountryComponent.ɵfac = function NewFilterCountryComponent_Factory(t) { return new (t || NewFilterCountryComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
NewFilterCountryComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: NewFilterCountryComponent, selectors: [["mobile-new-filter-country"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "h-fit", "min-h-screen"], [3, "title", "back"], ["class", "flex flex-row items-center py-4", 3, "click", 4, "ngFor", "ngForOf"], [1, "flex", "flex-row", "items-center", "py-4", 3, "click"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"]], template: function NewFilterCountryComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, NewFilterCountryComponent_ng_template_0_Template, 4, 2, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgForOf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJuZXctZmlsdGVyLWNvdW50cnkuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 6649:
/*!***************************************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-filter/new-filter/new-filter-page/new-filter-page.component.ts ***!
  \***************************************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "NewFilterPageComponent": () => (/* binding */ NewFilterPageComponent)
/* harmony export */ });
/* harmony import */ var apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! apps/mobile/src/app/common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../common/header/header.component */ 7357);









function NewFilterPageComponent_ng_template_0_div_3_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function NewFilterPageComponent_ng_template_0_div_3_Template_div_click_0_listener() { const restoredCtx = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r5); const pageCode_r3 = restoredCtx.$implicit; const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r4.selectPageCode(pageCode_r3.value)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](1, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](3, "div", 7)(4, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const pageCode_r3 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](pageCode_r3.label);
} }
function NewFilterPageComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("back", function NewFilterPageComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r6.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](3, NewFilterPageComponent_ng_template_0_div_3_Template, 5, 1, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsFilter.modal.page.label"));
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngForOf", ctx_r0.pageCodes);
} }
class NewFilterPageComponent {
    constructor(router, route, translocoService, settingsService) {
        this.router = router;
        this.route = route;
        this.translocoService = translocoService;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    selectPageCode(pageCode) {
        this.settingsService.filterForm.get('Page')?.setValue(pageCode);
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    get pageCodes() {
        return [
            { label: this.translocoService.translate('webDemo.settings.documentsFilter.modal.page.any'), value: '' },
            { label: this.translocoService.translate('webDemo.settings.documentsFilter.modal.page.front'), value: 'F' },
            { label: this.translocoService.translate('webDemo.settings.documentsFilter.modal.page.back'), value: 'B' }
        ];
    }
}
NewFilterPageComponent.ɵfac = function NewFilterPageComponent_Factory(t) { return new (t || NewFilterPageComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_3__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoService), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
NewFilterPageComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: NewFilterPageComponent, selectors: [["mobile-new-filter-page"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [3, "title", "back"], ["class", "flex flex-row items-center py-4", 3, "click", 4, "ngFor", "ngForOf"], [1, "flex", "flex-row", "items-center", "py-4", 3, "click"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"]], template: function NewFilterPageComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](0, NewFilterPageComponent_ng_template_0_Template, 4, 2, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgForOf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_4__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_1__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJuZXctZmlsdGVyLXBhZ2UuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 2473:
/*!***************************************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-filter/new-filter/new-filter-role/new-filter-role.component.ts ***!
  \***************************************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "NewFilterRoleComponent": () => (/* binding */ NewFilterRoleComponent)
/* harmony export */ });
/* harmony import */ var apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! apps/mobile/src/app/common/services/settings.service */ 8262);
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../common/header/header.component */ 7357);









function NewFilterRoleComponent_ng_template_0_div_3_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function NewFilterRoleComponent_ng_template_0_div_3_Template_div_click_0_listener() { const restoredCtx = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r5); const documentRole_r3 = restoredCtx.$implicit; const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r4.selectRole(documentRole_r3)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](1, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](3, "div", 7)(4, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
} if (rf & 2) {
    const documentRole_r3 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](documentRole_r3);
} }
function NewFilterRoleComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("back", function NewFilterRoleComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r7); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r6.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](3, NewFilterRoleComponent_ng_template_0_div_3_Template, 5, 1, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsFilter.modal.role"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngForOf", ctx_r0.documentRoles);
} }
class NewFilterRoleComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    selectRole(role) {
        this.settingsService.filterForm.get('Role')?.setValue(role);
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    get documentRoles() {
        const rolesFull = Object.values(libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_1__.ZenidDocumentRoles);
        const length = Math.ceil(rolesFull.length / 2);
        return rolesFull.splice(0, length);
    }
}
NewFilterRoleComponent.ɵfac = function NewFilterRoleComponent_Factory(t) { return new (t || NewFilterRoleComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](apps_mobile_src_app_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
NewFilterRoleComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: NewFilterRoleComponent, selectors: [["mobile-new-filter-role"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", "h-fit", "min-h-screen"], [3, "title", "back"], ["class", "flex flex-row items-center py-4", 3, "click", 4, "ngFor", "ngForOf"], [1, "flex", "flex-row", "items-center", "py-4", 3, "click"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"]], template: function NewFilterRoleComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, NewFilterRoleComponent_ng_template_0_Template, 4, 2, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_5__.NgForOf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJuZXctZmlsdGVyLXJvbGUuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 3286:
/*!******************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-filter/new-filter/new-filter.component.ts ***!
  \******************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "NewFilterComponent": () => (/* binding */ NewFilterComponent)
/* harmony export */ });
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../common/header/header.component */ 7357);








function NewFilterComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("back", function NewFilterComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r2.back()); })("submit", function NewFilterComponent_ng_template_0_Template_mobile_header_submit_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r4.submit()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](3, "div", 4)(4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](6, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](7, "span", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](9, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](10, "div", 9)(11, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](12);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](13, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](14, "span", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](16, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](17, "div", 10)(18, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](19);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](20, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](21, "span", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](22);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](23, "i", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    let tmp_2_0;
    let tmp_4_0;
    let tmp_6_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsFilter.modal.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documentsFilter.modal.role"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"]((tmp_2_0 = ctx_r0.filterForm.get("Role")) == null ? null : tmp_2_0.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documentsFilter.modal.country"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](ctx_r0.getCountryDisplayName((tmp_4_0 = ctx_r0.filterForm.get("Country")) == null ? null : tmp_4_0.value));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documentsFilter.modal.page.label"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](((tmp_6_0 = ctx_r0.filterForm.get("Page")) == null ? null : tmp_6_0.value) === "" ? t_r1("webDemo.settings.documentsFilter.modal.page.any") : (tmp_6_0 = ctx_r0.filterForm.get("Page")) == null ? null : tmp_6_0.value);
} }
class NewFilterComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.settingsService.filterForm.reset();
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    submit() {
        this.settingsService.appendFilter();
        this.settingsService.filterForm.reset();
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    getCountryDisplayName(codeString) {
        const contryDisplayName = libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__.zenidContriesFull.find((country) => country.codeString === codeString)?.displayName;
        return contryDisplayName ? contryDisplayName : '';
    }
    get filterForm() {
        return this.settingsService.filterForm;
    }
}
NewFilterComponent.ɵfac = function NewFilterComponent_Factory(t) { return new (t || NewFilterComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_1__.SettingsService)); };
NewFilterComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: NewFilterComponent, selectors: [["mobile-new-filter"]], decls: 2, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [3, "title", "back", "submit"], ["routerLink", "role", 1, "flex", "flex-row", "items-center", "py-4"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "mr-4", "text-s15", "text-light-base-02", "dark:text-dark-base-02"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"], ["routerLink", "country", 1, "flex", "flex-row", "items-center", "py-4"], ["routerLink", "page", 1, "flex", "flex-row", "items-center", "py-4"]], template: function NewFilterComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, NewFilterComponent_ng_template_0_Template, 24, 7, "ng-template", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](1, "router-outlet");
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_4__.RouterOutlet, _angular_router__WEBPACK_IMPORTED_MODULE_4__.RouterLink, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJuZXctZmlsdGVyLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 7777:
/*!*****************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/documents-verifier/documents-verifier.component.ts ***!
  \*****************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DocumentsVerifierComponent": () => (/* binding */ DocumentsVerifierComponent)
/* harmony export */ });
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _libs_ui_src_lib_common_form_input_input_range_input_range_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/input/input-range/input-range.component */ 7707);
/* harmony import */ var _libs_ui_src_lib_common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/input/input-checkbox/input-checkbox.component */ 4325);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../common/header/header.component */ 7357);










function DocumentsVerifierComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("back", function DocumentsVerifierComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresetView"](ctx_r2.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](4, "zenid-input-range", 5)(5, "zenid-input-range", 6)(6, "zenid-input-range", 7)(7, "zenid-input-checkbox", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("formGroup", ctx_r0.form);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("title", t_r1("webDemo.settings.documentsVerifier.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate"]("label", t_r1("webDemo.settings.documentsVerifier.specularAcceptableScore"));
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate"]("label", t_r1("webDemo.settings.documentsVerifier.documentBlurAcceptableScore"));
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate"]("label", t_r1("webDemo.settings.documentsVerifier.timeToBlurMaxTolerance"));
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate"]("label", t_r1("webDemo.settings.documentsVerifier.showTimer"));
} }
class DocumentsVerifierComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    get form() {
        return this.settingsService.form;
    }
}
DocumentsVerifierComponent.ɵfac = function DocumentsVerifierComponent_Factory(t) { return new (t || DocumentsVerifierComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_5__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_5__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
DocumentsVerifierComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdefineComponent"]({ type: DocumentsVerifierComponent, selectors: [["mobile-documents-verifier"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", 3, "formGroup"], [3, "title", "back"], ["formGroupName", "DocumentsVerifier"], ["formControlName", "specularAcceptableScore", 3, "label"], ["formControlName", "documentBlurAcceptableScore", 3, "label"], ["formControlName", "timeToBlurMaxTolerance", 3, "label"], ["formControlName", "showTimer", 3, "label"]], template: function DocumentsVerifierComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtemplate"](0, DocumentsVerifierComponent_ng_template_0_Template, 8, 6, "ng-template", 0);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_6__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.NgControlStatusGroup, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.FormGroupDirective, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.FormControlName, _angular_forms__WEBPACK_IMPORTED_MODULE_6__.FormGroupName, _libs_ui_src_lib_common_form_input_input_range_input_range_component__WEBPACK_IMPORTED_MODULE_1__.InputRangeComponent, _libs_ui_src_lib_common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_2__.InputCheckboxComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_7__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_3__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJkb2N1bWVudHMtdmVyaWZpZXIuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 8098:
/*!*******************************************************************************************!*\
  !*** ./apps/mobile/src/app/settings/selfie-verification/selfie-verification.component.ts ***!
  \*******************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SelfieVerificationComponent": () => (/* binding */ SelfieVerificationComponent)
/* harmony export */ });
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _libs_ui_src_lib_common_form_input_input_radio_input_radio_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../../libs/ui/src/lib/common/form/input/input-radio/input-radio.component */ 977);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../common/header/header.component */ 7357);









const _c0 = function () { return { label: "None", value: "none" }; };
const _c1 = function () { return { label: "Selfie Match", value: "selfie" }; };
const _c2 = function () { return { label: "Liveness Check", value: "liveness" }; };
const _c3 = function () { return { label: "Liveness Check Legacy", value: "livenessLegacy" }; };
const _c4 = function (a0, a1, a2, a3) { return [a0, a1, a2, a3]; };
function SelfieVerificationComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("back", function SelfieVerificationComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r2.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](3, "zenid-input-radio", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("formGroup", ctx_r0.form);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("title", t_r1("webDemo.settings.selfieVerification.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("options", _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpureFunction4"](7, _c4, _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpureFunction0"](3, _c0), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpureFunction0"](4, _c1), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpureFunction0"](5, _c2), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpureFunction0"](6, _c3)));
} }
class SelfieVerificationComponent {
    constructor(router, route, settingsService) {
        this.router = router;
        this.route = route;
        this.settingsService = settingsService;
    }
    back() {
        this.router.navigate(['..'], { relativeTo: this.route });
    }
    get form() {
        return this.settingsService.form;
    }
}
SelfieVerificationComponent.ɵfac = function SelfieVerificationComponent_Factory(t) { return new (t || SelfieVerificationComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.Router), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__.ActivatedRoute), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_0__.SettingsService)); };
SelfieVerificationComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: SelfieVerificationComponent, selectors: [["mobile-selfie"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", 3, "formGroup"], [3, "title", "back"], ["formControlName", "selfieVerification", 3, "options"]], template: function SelfieVerificationComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, SelfieVerificationComponent_ng_template_0_Template, 4, 12, "ng-template", 0);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_5__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.NgControlStatusGroup, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.FormGroupDirective, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.FormControlName, _libs_ui_src_lib_common_form_input_input_radio_input_radio_component__WEBPACK_IMPORTED_MODULE_1__.InputRadioComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_6__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_2__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzZWxmaWUtdmVyaWZpY2F0aW9uLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 4403:
/*!************************************************************!*\
  !*** ./apps/mobile/src/app/settings/settings.component.ts ***!
  \************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SettingsComponent": () => (/* binding */ SettingsComponent)
/* harmony export */ });
/* harmony import */ var libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! libs/zenid-web-sdk/src/lib/zenid.enum */ 1853);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _common_services_settings_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../common/services/settings.service */ 8262);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _libs_ui_src_lib_common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../../libs/ui/src/lib/common/form/input/input-checkbox/input-checkbox.component */ 4325);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./common/header/header.component */ 7357);











function SettingsComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "mobile-header", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵlistener"]("back", function SettingsComponent_ng_template_0_Template_mobile_header_back_2_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵresetView"](ctx_r2.back()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](3, "div", 4)(4, "div")(5, "div", 5)(6, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](8, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](9, "span", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](10);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](11, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](12, "div", 10)(13, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](14);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](15, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](16, "span", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](18, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](19, "div")(20, "span", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](21);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](22, "div", 12)(23, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](24);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](25, "div", 7)(26, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](27, "div", 13)(28, "span", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](29);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](30, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](31, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtext"](32);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](33, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementStart"](34, "div");
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](35, "zenid-input-checkbox", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵnextContext"]();
    let tmp_3_0;
    let tmp_5_0;
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵproperty"]("formGroup", ctx_r0.form);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵproperty"]("title", t_r1("webDemo.settings.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](t_r1("webDemo.settings.country"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](ctx_r0.getCountryDisplayName((tmp_3_0 = ctx_r0.form.get("country")) == null ? null : tmp_3_0.value));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](t_r1("webDemo.settings.selfieVerification.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"]((tmp_5_0 = ctx_r0.form.get("selfieVerification")) == null ? null : tmp_5_0.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documents"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documentsVerifier.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate"](t_r1("webDemo.settings.documentsFilter.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtextInterpolate1"](" ", ctx_r0.documentsFilterArray.controls.length, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵpropertyInterpolate"]("label", t_r1("webDemo.settings.debugMode"));
} }
class SettingsComponent {
    constructor(messageService, settingsService) {
        this.messageService = messageService;
        this.settingsService = settingsService;
    }
    back() {
        this.messageService.sendBackPressed({ data: this.settingsService.form.value });
    }
    get documentsFilterArray() {
        return this.settingsService.form.get('DocumentsFilter');
    }
    get form() {
        return this.settingsService.form;
    }
    getCountryDisplayName(codeString) {
        const contryDisplayName = libs_zenid_web_sdk_src_lib_zenid_enum__WEBPACK_IMPORTED_MODULE_0__.zenidContriesFull.find((country) => country.codeString === codeString)?.displayName;
        return contryDisplayName ? contryDisplayName : '';
    }
}
SettingsComponent.ɵfac = function SettingsComponent_Factory(t) { return new (t || SettingsComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_1__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵdirectiveInject"](_common_services_settings_service__WEBPACK_IMPORTED_MODULE_2__.SettingsService)); };
SettingsComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵdefineComponent"]({ type: SettingsComponent, selectors: [["mobile-settings"]], decls: 2, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile", 3, "formGroup"], [3, "title", "back"], [1, "divide-y", "divide-light-gray-01"], ["routerLink", "country", 1, "flex", "flex-row", "items-center", "py-4"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "mr-4", "text-s15", "text-light-base-02", "dark:text-dark-base-02"], [1, "ci-chevron_right", "text-s22", "text-light-base-02", "dark:text-dark-base-02"], ["routerLink", "selfie", 1, "flex", "flex-row", "items-center", "py-4"], [1, "flex", "flex-row", "pt-4", "text-s15", "text-light-base-02", "dark:text-dark-base-02"], ["routerLink", "documents-verifier", 1, "flex", "flex-row", "items-center", "py-4"], ["routerLink", "documents-filter", 1, "flex", "flex-row", "items-center", "py-4"], [1, "mr-4", "flex", "h-[22px]", "w-[22px]", "items-center", "justify-center", "rounded-full", "bg-light-base-00", "text-s12", "text-light-paper", "dark:bg-dark-base-00", "dark:text-dark-paper"], ["formControlName", "debugMode", 3, "label"]], template: function SettingsComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵtemplate"](0, SettingsComponent_ng_template_0_Template, 36, 11, "ng-template", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_5__["ɵɵelement"](1, "router-outlet");
    } }, dependencies: [_angular_router__WEBPACK_IMPORTED_MODULE_6__.RouterOutlet, _angular_router__WEBPACK_IMPORTED_MODULE_6__.RouterLink, _angular_forms__WEBPACK_IMPORTED_MODULE_7__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_7__.NgControlStatusGroup, _angular_forms__WEBPACK_IMPORTED_MODULE_7__.FormGroupDirective, _angular_forms__WEBPACK_IMPORTED_MODULE_7__.FormControlName, _libs_ui_src_lib_common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_3__.InputCheckboxComponent, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_8__.TranslocoDirective, _common_header_header_component__WEBPACK_IMPORTED_MODULE_4__.HeaderComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzZXR0aW5ncy5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 2118:
/*!*********************************************************!*\
  !*** ./apps/mobile/src/app/settings/settings.module.ts ***!
  \*********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "SettingsModule": () => (/* binding */ SettingsModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_14__ = __webpack_require__(/*! @angular/router */ 124);
/* harmony import */ var _settings_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./settings.component */ 4403);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_15__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _zenid_ui__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @zenid/ui */ 9142);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _country_country_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./country/country.component */ 2733);
/* harmony import */ var _selfie_verification_selfie_verification_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./selfie-verification/selfie-verification.component */ 8098);
/* harmony import */ var _documents_verifier_documents_verifier_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./documents-verifier/documents-verifier.component */ 7777);
/* harmony import */ var _documents_filter_documents_filter_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./documents-filter/documents-filter.component */ 6941);
/* harmony import */ var _common_header_header_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ./common/header/header.component */ 7357);
/* harmony import */ var _documents_filter_new_filter_new_filter_component__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ./documents-filter/new-filter/new-filter.component */ 3286);
/* harmony import */ var _documents_filter_new_filter_new_filter_role_new_filter_role_component__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ./documents-filter/new-filter/new-filter-role/new-filter-role.component */ 2473);
/* harmony import */ var _documents_filter_new_filter_new_filter_country_new_filter_country_component__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! ./documents-filter/new-filter/new-filter-country/new-filter-country.component */ 511);
/* harmony import */ var _documents_filter_new_filter_new_filter_page_new_filter_page_component__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! ./documents-filter/new-filter/new-filter-page/new-filter-page.component */ 6649);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! @angular/core */ 2560);

















const routes = [
    {
        path: 'settings',
        children: [
            {
                path: '',
                pathMatch: 'full',
                component: _settings_component__WEBPACK_IMPORTED_MODULE_0__.SettingsComponent
            },
            {
                path: 'selfie',
                component: _selfie_verification_selfie_verification_component__WEBPACK_IMPORTED_MODULE_4__.SelfieVerificationComponent
            },
            {
                path: 'country',
                component: _country_country_component__WEBPACK_IMPORTED_MODULE_3__.CountryComponent
            },
            {
                path: 'documents-verifier',
                component: _documents_verifier_documents_verifier_component__WEBPACK_IMPORTED_MODULE_5__.DocumentsVerifierComponent
            },
            {
                path: 'documents-filter',
                children: [
                    {
                        path: '',
                        pathMatch: 'full',
                        component: _documents_filter_documents_filter_component__WEBPACK_IMPORTED_MODULE_6__.DocumentsFilterComponent
                    },
                    {
                        path: 'new',
                        children: [
                            {
                                path: '',
                                pathMatch: 'full',
                                component: _documents_filter_new_filter_new_filter_component__WEBPACK_IMPORTED_MODULE_8__.NewFilterComponent
                            },
                            {
                                path: 'role',
                                component: _documents_filter_new_filter_new_filter_role_new_filter_role_component__WEBPACK_IMPORTED_MODULE_9__.NewFilterRoleComponent
                            },
                            {
                                path: 'country',
                                component: _documents_filter_new_filter_new_filter_country_new_filter_country_component__WEBPACK_IMPORTED_MODULE_10__.NewFilterCountryComponent
                            },
                            {
                                path: 'page',
                                component: _documents_filter_new_filter_new_filter_page_new_filter_page_component__WEBPACK_IMPORTED_MODULE_11__.NewFilterPageComponent
                            }
                        ]
                    }
                ]
            }
        ]
    }
];
class SettingsModule {
}
SettingsModule.ɵfac = function SettingsModule_Factory(t) { return new (t || SettingsModule)(); };
SettingsModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_12__["ɵɵdefineNgModule"]({ type: SettingsModule });
SettingsModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_12__["ɵɵdefineInjector"]({ imports: [_angular_common__WEBPACK_IMPORTED_MODULE_13__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_14__.RouterModule.forChild(routes), _angular_forms__WEBPACK_IMPORTED_MODULE_15__.ReactiveFormsModule, _zenid_ui__WEBPACK_IMPORTED_MODULE_1__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_2__.UtilModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_12__["ɵɵsetNgModuleScope"](SettingsModule, { declarations: [_settings_component__WEBPACK_IMPORTED_MODULE_0__.SettingsComponent,
        _selfie_verification_selfie_verification_component__WEBPACK_IMPORTED_MODULE_4__.SelfieVerificationComponent,
        _country_country_component__WEBPACK_IMPORTED_MODULE_3__.CountryComponent,
        _documents_verifier_documents_verifier_component__WEBPACK_IMPORTED_MODULE_5__.DocumentsVerifierComponent,
        _documents_filter_documents_filter_component__WEBPACK_IMPORTED_MODULE_6__.DocumentsFilterComponent,
        _common_header_header_component__WEBPACK_IMPORTED_MODULE_7__.HeaderComponent,
        _documents_filter_new_filter_new_filter_component__WEBPACK_IMPORTED_MODULE_8__.NewFilterComponent,
        _documents_filter_new_filter_new_filter_role_new_filter_role_component__WEBPACK_IMPORTED_MODULE_9__.NewFilterRoleComponent,
        _documents_filter_new_filter_new_filter_country_new_filter_country_component__WEBPACK_IMPORTED_MODULE_10__.NewFilterCountryComponent,
        _documents_filter_new_filter_new_filter_page_new_filter_page_component__WEBPACK_IMPORTED_MODULE_11__.NewFilterPageComponent], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_13__.CommonModule, _angular_router__WEBPACK_IMPORTED_MODULE_14__.RouterModule, _angular_forms__WEBPACK_IMPORTED_MODULE_15__.ReactiveFormsModule, _zenid_ui__WEBPACK_IMPORTED_MODULE_1__.UiModule, _zenid_util__WEBPACK_IMPORTED_MODULE_2__.UtilModule] }); })();


/***/ }),

/***/ 6:
/*!**********************************************************!*\
  !*** ./apps/mobile/src/app/welcome/welcome.component.ts ***!
  \**********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "WelcomeComponent": () => (/* binding */ WelcomeComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _common_services_message_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../common/services/message.service */ 5923);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../libs/ui/src/lib/common/form/button/button.component */ 7942);









const _c0 = ["welcomeSlider"];
const _c1 = ["stepper"];
function WelcomeComponent_ng_template_0_lottie_player_21_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](0, "lottie-player", 26);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function WelcomeComponent_ng_template_0_ng_container_50_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementContainerStart"](0);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](2, "a", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](5, "a", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementContainerEnd"]();
} if (rf & 2) {
    const t_r7 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r7("text1"), "");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("href", t_r7("href1"), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r7("a1"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r7("text2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("href", t_r7("href2"), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r7("a2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"]("", t_r7("text3"), " ");
} }
function WelcomeComponent_ng_template_0_ng_container_52_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementContainerStart"](0);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](2, "a", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](5, "a", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementContainerEnd"]();
} if (rf & 2) {
    const t_r8 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r8("text1"), "");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("href", t_r8("href1"), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r8("a1"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r8("text2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("href", t_r8("href2"), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵsanitizeUrl"]);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate"](t_r8("a2"));
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"]("", t_r8("text3"), " ");
} }
function WelcomeComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r10 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 1)(1, "div", 2)(2, "div", 3)(3, "div", 4)(4, "p", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](6, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](8, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](9, "zenid-button", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](10);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](11, "div", 4)(12, "p", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](14, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](16, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](17, "zenid-button", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function WelcomeComponent_ng_template_0_Template_zenid_button_click_17_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r10); const ctx_r9 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r9.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](18);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](19, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](20, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](21, WelcomeComponent_ng_template_0_lottie_player_21_Template, 1, 1, "lottie-player", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](22, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](23, "div", 12, 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("scroll", function WelcomeComponent_ng_template_0_Template_div_scroll_23_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r10); const ctx_r11 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r11.scrollHandler()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](25, "div", 14)(26, "p", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](27);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](28, "p", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](29);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](30, "div", 14)(31, "p", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](32);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](33, "p", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](34);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](35, "div", 14)(36, "p", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](37);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](38, "p", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](39);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](40, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](41, "div", 18, 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](43, "div", 20)(44, "div", 21)(45, "div", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](46, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](47, "zenid-button", 22);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function WelcomeComponent_ng_template_0_Template_zenid_button_click_47_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r10); const ctx_r12 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r12.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](48);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](49, "p", 23);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](50, WelcomeComponent_ng_template_0_ng_container_50_Template, 8, 7, "ng-container", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](51, "p", 25);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](52, WelcomeComponent_ng_template_0_ng_container_52_Template, 8, 7, "ng-container", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("welcome.titleMobile"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.descMobile"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.buttonMobile"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.titleWebDemo"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.descWebDemo"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.buttonWebDemo"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item1.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item1.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item2.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item2.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item3.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.item3.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](9);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r1("webDemo.welcome.mobile.submitButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("translocoRead", "webDemo.welcome.mobile.agreement");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("translocoRead", "webDemo.welcome.agreement");
} }
class WelcomeComponent {
    constructor(renderer, messageService, uiService) {
        this.renderer = renderer;
        this.messageService = messageService;
        this.uiService = uiService;
        // used to detect when horizontal scrolling is over
        this.timer = null;
    }
    ngOnInit() {
        this.animationSrc = JSON.stringify(this.uiService.animations['welcome']);
    }
    nextClicked() {
        this.messageService.sendNextPressed();
    }
    /*
     * Scrolling event start. Inspired by https://stackoverflow.com/a/68307859/14807150
     */
    scrollHandler() {
        clearTimeout(this.timer);
        this.timer = setTimeout(() => {
            const childrenArray = this.welcomeSlider.nativeElement.children;
            Array.from(childrenArray).forEach((element, index) => {
                let contentIndex = index;
                if (Math.abs(element.getBoundingClientRect().left -
                    this.welcomeSlider.nativeElement.getBoundingClientRect().left) < 10) {
                    Array.from(this.stepper.nativeElement.children).forEach((element, index) => {
                        if (contentIndex == index) {
                            this.renderer.addClass(element, 'bg-light-base-00');
                            this.renderer.addClass(element, 'dark:bg-dark-base-00');
                            this.renderer.removeClass(element, 'bg-light-gray-01');
                            this.renderer.removeClass(element, 'dark:bg-dark-gray-01');
                        }
                        else {
                            this.renderer.addClass(element, 'bg-light-gray-01');
                            this.renderer.addClass(element, 'dark:bg-dark-gray-01');
                            this.renderer.removeClass(element, 'bg-light-base-00');
                            this.renderer.removeClass(element, 'dark:bg-dark-base-00');
                        }
                    });
                }
            });
        }, 100);
    }
}
WelcomeComponent.ɵfac = function WelcomeComponent_Factory(t) { return new (t || WelcomeComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_3__.Renderer2), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_common_services_message_service__WEBPACK_IMPORTED_MODULE_1__.MessageService), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService)); };
WelcomeComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: WelcomeComponent, selectors: [["mobile-welcome"]], viewQuery: function WelcomeComponent_Query(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵviewQuery"](_c0, 5);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵviewQuery"](_c1, 5);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵloadQuery"]()) && (ctx.welcomeSlider = _t.first);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵloadQuery"]()) && (ctx.stepper = _t.first);
    } }, decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper-mobile"], [1, "main-container-mobile"], [1, "hidden", "flex-row", "divide-x", "divide-light-gray-01", "dark:divide-dark-gray-01", "sm:flex"], [1, "flex", "basis-1/2", "flex-col", "text-center"], [1, "mb-4", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-8", "text-s13", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], ["classes", "secondary-button"], ["classes", "primary-button", 3, "click"], [1, "flex", "h-full", "flex-col", "text-center", "sm:hidden"], ["autoplay", "", "loop", "", "mode", "normal", "class", "h-fit", 3, "src", 4, "ngIf"], [1, "welcome-slider", "flex", "snap-x", "snap-mandatory", "space-x-4", "overflow-x-scroll", 3, "scroll"], ["welcomeSlider", ""], [1, "w-full", "flex-none", "snap-center", "snap-always"], [1, "text-light-base-0", "mt-14", "mb-4", "text-s22", "font-bold", "dark:text-dark-base-01"], [1, "text-s13", "font-normal", "text-light-base-02", "dark:text-dark-base-02"], [1, "mt-14", "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "flex", "flex-row", "justify-center", "space-x-2"], ["stepper", ""], [1, "h-2", "w-2", "rounded-full", "bg-light-base-00", "dark:bg-dark-base-00"], [1, "h-2", "w-2", "rounded-full", "bg-light-gray-01", "dark:bg-dark-gray-01"], ["classes", "primary-button w-full", 3, "click"], [1, "mt-4", "text-center", "text-s12", "text-light-base-01", "dark:text-dark-base-01"], [4, "transloco", "translocoRead"], [1, "hidden", "px-32", "text-center", "text-s12", "text-light-base-01", "dark:text-dark-base-01", "sm:block"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", 3, "src"], ["target", "_blank", 1, "text-light-base-00", "hover:text-light-base-03", "dark:text-dark-base-00", "dark:hover:text-dark-base-03", 3, "href"]], template: function WelcomeComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, WelcomeComponent_ng_template_0_Template, 53, 16, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_4__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective, _libs_ui_src_lib_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_2__.ButtonComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJ3ZWxjb21lLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 3238:
/*!*****************************************************!*\
  !*** ./apps/mobile/src/environments/environment.ts ***!
  \*****************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "environment": () => (/* binding */ environment)
/* harmony export */ });
const environment = {
    production: false,
    config: {
        appRoot: './'
    },
    settings: {
        Colors: {
            primaryColor: '#3251df',
            primaryColorDarken: '#1938c6',
            secondaryColor: '#ebeefc',
            contrastColor: '#ffffff',
            darkPrimaryColor: '#7b8fea',
            darkPrimaryColorDarken: '#6272bb',
            darkSecondaryColor: '#2f4250',
            darkContrastColor: '#ffffff'
        },
        darkMode: false
    }
};


/***/ }),

/***/ 1887:
/*!*********************************!*\
  !*** ./apps/mobile/src/main.ts ***!
  \*********************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/platform-browser */ 4497);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _app_app_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./app/app.module */ 8095);
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./environments/environment */ 3238);




if (_environments_environment__WEBPACK_IMPORTED_MODULE_1__.environment.production) {
    (0,_angular_core__WEBPACK_IMPORTED_MODULE_2__.enableProdMode)();
}
_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__.platformBrowser()
    .bootstrapModule(_app_app_module__WEBPACK_IMPORTED_MODULE_0__.AppModule)
    .catch((err) => console.error(err));


/***/ }),

/***/ 9363:
/*!***************************************!*\
  !*** ./libs/data-access/src/index.ts ***!
  \***************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DataAccessModule": () => (/* reexport safe */ _lib_data_access_module__WEBPACK_IMPORTED_MODULE_0__.DataAccessModule),
/* harmony export */   "UiService": () => (/* reexport safe */ _lib_ui_ui_service__WEBPACK_IMPORTED_MODULE_2__.UiService)
/* harmony export */ });
/* harmony import */ var _lib_data_access_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./lib/data-access.module */ 119);
/* harmony import */ var _lib_ui_ui_model__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./lib/ui/ui.model */ 7792);
/* harmony import */ var _lib_ui_ui_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./lib/ui/ui.service */ 7725);





/***/ }),

/***/ 119:
/*!********************************************************!*\
  !*** ./libs/data-access/src/lib/data-access.module.ts ***!
  \********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DataAccessModule": () => (/* binding */ DataAccessModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ui_ui_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./ui/ui.service */ 7725);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);



class DataAccessModule {
}
DataAccessModule.ɵfac = function DataAccessModule_Factory(t) { return new (t || DataAccessModule)(); };
DataAccessModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineNgModule"]({ type: DataAccessModule });
DataAccessModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineInjector"]({ providers: [_ui_ui_service__WEBPACK_IMPORTED_MODULE_0__.UiService], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_2__.CommonModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵsetNgModuleScope"](DataAccessModule, { imports: [_angular_common__WEBPACK_IMPORTED_MODULE_2__.CommonModule] }); })();


/***/ }),

/***/ 7792:
/*!*************************************************!*\
  !*** ./libs/data-access/src/lib/ui/ui.model.ts ***!
  \*************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);



/***/ }),

/***/ 7725:
/*!***************************************************!*\
  !*** ./libs/data-access/src/lib/ui/ui.service.ts ***!
  \***************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "UiService": () => (/* binding */ UiService)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);

class UiService {
    constructor() {
        this._modals = [];
        this._animations = {};
    }
    get animations() {
        return this._animations;
    }
    set animations(value) {
        this._animations = value;
    }
    addModal(modal) {
        // add modal to array of active modals
        this._modals.push(modal);
    }
    removeModal(id) {
        // remove modal from array of active modals
        this._modals = this._modals.filter((x) => x.id !== id);
    }
    openModal(id) {
        // open modal specified by id
        const modal = this._modals.find((x) => x.id === id);
        modal.open();
    }
    closeModal(id) {
        // close modal specified by id
        const modal = this._modals.find((x) => x.id === id);
        modal.close();
    }
}
UiService.ɵfac = function UiService_Factory(t) { return new (t || UiService)(); };
UiService.ɵprov = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({ token: UiService, factory: UiService.ɵfac, providedIn: 'root' });


/***/ }),

/***/ 9142:
/*!******************************!*\
  !*** ./libs/ui/src/index.ts ***!
  \******************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AlertTypesEnum": () => (/* reexport safe */ _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__.AlertTypesEnum),
/* harmony export */   "AnalyzingComponent": () => (/* reexport safe */ _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__.AnalyzingComponent),
/* harmony export */   "CameraAccessComponent": () => (/* reexport safe */ _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__.CameraAccessComponent),
/* harmony export */   "ModalComponent": () => (/* reexport safe */ _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__.ModalComponent),
/* harmony export */   "UiModule": () => (/* reexport safe */ _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__.UiModule)
/* harmony export */ });
/* harmony import */ var _lib_ui_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./lib/ui.module */ 6546);



/***/ }),

/***/ 3929:
/*!*********************************************************!*\
  !*** ./libs/ui/src/lib/common/alert/alert.component.ts ***!
  \*********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AlertComponent": () => (/* binding */ AlertComponent),
/* harmony export */   "AlertTypesEnum": () => (/* binding */ AlertTypesEnum)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../form/button/button.component */ 7942);






const _c0 = ["player"];
function AlertComponent_p_7_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "p", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
} if (rf & 2) {
    const ctx_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](ctx_r1.errorText);
} }
function AlertComponent_div_9_Template(rf, ctx) { if (rf & 1) {
    const _r4 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 9)(1, "zenid-button", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵlistener"]("click", function AlertComponent_div_9_Template_zenid_button_click_1_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵrestoreView"](_r4); const ctx_r3 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵresetView"](ctx_r3.nextClicked()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("withIcon", ctx_r2.buttonWithIcon);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx_r2.buttonTitle, " ");
} }
var AlertTypesEnum;
(function (AlertTypesEnum) {
    AlertTypesEnum[AlertTypesEnum["Success"] = 0] = "Success";
    AlertTypesEnum[AlertTypesEnum["Error"] = 1] = "Error";
    AlertTypesEnum[AlertTypesEnum["Warning"] = 2] = "Warning";
})(AlertTypesEnum || (AlertTypesEnum = {}));
class AlertComponent {
    constructor(uiService) {
        this.uiService = uiService;
        this.buttonWithIcon = false;
        this.assetMapping = ['success', 'error', 'warning'];
        this.next = new _angular_core__WEBPACK_IMPORTED_MODULE_2__.EventEmitter();
    }
    ngAfterViewInit() {
        const player = this.player.nativeElement;
        // Temp fix - sometimes load ends with error
        setTimeout(() => player.load(this.uiService.animations[this.assetMapping[this.type]]));
    }
    nextClicked() {
        this.next.emit();
    }
}
AlertComponent.ɵfac = function AlertComponent_Factory(t) { return new (t || AlertComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService)); };
AlertComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: AlertComponent, selectors: [["zenid-alert"]], viewQuery: function AlertComponent_Query(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵviewQuery"](_c0, 5);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵloadQuery"]()) && (ctx.player = _t.first);
    } }, inputs: { type: "type", title: "title", desc: "desc", errorText: "errorText", buttonTitle: "buttonTitle", buttonWithIcon: "buttonWithIcon" }, outputs: { next: "next" }, decls: 10, vars: 4, consts: [[1, "flex", "h-full", "flex-col"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40"], ["player", ""], [1, "mb-4", "text-s22", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:text-s17"], [1, "mb-8", "text-s13", "text-light-base-02", "dark:text-dark-base-02", "sm:text-light-base-01", "dark:sm:text-dark-base-01"], ["class", "mb-8 break-words text-s13 text-light-base-02 dark:text-dark-base-02", 4, "ngIf"], [1, "grow", "sm:hidden"], ["class", "block", 4, "ngIf"], [1, "mb-8", "break-words", "text-s13", "text-light-base-02", "dark:text-dark-base-02"], [1, "block"], ["classes", "primary-button w-full sm:w-fit", 3, "withIcon", "click"]], template: function AlertComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](1, "lottie-player", 1, 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](3, "p", 3);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](4);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](5, "p", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtext"](6);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](7, AlertComponent_p_7_Template, 2, 1, "p", 5);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](8, "div", 6);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtemplate"](9, AlertComponent_div_9_Template, 3, 2, "div", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](4);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate"](ctx.title);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵtextInterpolate1"](" ", ctx.desc, " ");
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx.errorText);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngIf", ctx.buttonTitle);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_3__.NgIf, _form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJhbGVydC5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 1243:
/*!*****************************************************************!*\
  !*** ./libs/ui/src/lib/common/analyzing/analyzing.component.ts ***!
  \*****************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AnalyzingComponent": () => (/* binding */ AnalyzingComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @ngneat/transloco */ 3091);





function AnalyzingComponent_ng_template_0_lottie_player_3_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](0, "lottie-player", 15);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function AnalyzingComponent_ng_template_0_div_10_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](1, "div", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
} }
function AnalyzingComponent_ng_template_0_div_11_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](1, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
} }
function AnalyzingComponent_ng_template_0_div_14_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
} if (rf & 2) {
    const t_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]().$implicit;
    const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("analyzing." + ctx_r5.selfieVerification), " ");
} }
function AnalyzingComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](3, AnalyzingComponent_ng_template_0_lottie_player_3_Template, 1, 1, "lottie-player", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](6, "div", 6)(7, "div", 7)(8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](9, "i", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](10, AnalyzingComponent_ng_template_0_div_10_Template, 2, 0, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](11, AnalyzingComponent_ng_template_0_div_11_Template, 2, 0, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](12, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](13);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](14, AnalyzingComponent_ng_template_0_div_14_Template, 2, 1, "div", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](15, "div", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("analyzing.title"));
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", t_r1("analyzing.document"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.showExpanded);
} }
class AnalyzingComponent {
    constructor(uiService, sdkService) {
        this.uiService = uiService;
        this.sdkService = sdkService;
        this.statusesSelfieForShow = ['selfie', 'liveness', 'livenessLegacy'];
        this.animationSrc = JSON.stringify(this.uiService.animations['analyzing']);
        this.selfieVerification = this.sdkService.settings.selfieVerification;
        this.showExpanded = this.statusesSelfieForShow.includes(this.selfieVerification);
    }
}
AnalyzingComponent.ɵfac = function AnalyzingComponent_Factory(t) { return new (t || AnalyzingComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"]('SdkService')); };
AnalyzingComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: AnalyzingComponent, selectors: [["zenid-analyzing"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper"], [1, "main-container"], [1, "grow"], ["autoplay", "", "loop", "", "mode", "normal", "class", "h-fit sm:h-40", 3, "src", 4, "ngIf"], [1, "mb-8", "text-center", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "grid", "grid-flow-col", "grid-rows-2", "gap-x-4", "gap-y-6"], [1, "row-span-2", "flex", "flex-col", "items-end"], [1, "flex", "h-6", "w-6", "items-center", "justify-center", "rounded-full", "bg-light-gray-01", "dark:bg-dark-gray-01"], [1, "ci-check", "text-light-base-02", "dark:text-dark-base-02"], ["class", "flex w-6 grow flex-row justify-center", 4, "ngIf"], ["class", "flex h-6 w-6 items-center justify-center rounded-full bg-light-gray-01 dark:bg-dark-gray-01", 4, "ngIf"], [1, "text-left", "text-s15", "text-light-base-01", "dark:text-dark-base-01"], ["class", "text-left text-s15 text-light-base-01 dark:text-dark-base-01", 4, "ngIf"], [1, "grow", "sm:hidden"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"], [1, "flex", "w-6", "grow", "flex-row", "justify-center"], [1, "h-full", "w-[1px]", "bg-light-gray-01", "dark:bg-dark-gray-01"]], template: function AnalyzingComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](0, AnalyzingComponent_ng_template_0_Template, 16, 6, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_2__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJhbmFseXppbmcuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 7997:
/*!*************************************************************************!*\
  !*** ./libs/ui/src/lib/common/camera-access/camera-access.component.ts ***!
  \*************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "CameraAccessComponent": () => (/* binding */ CameraAccessComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _form_button_button_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../form/button/button.component */ 7942);
/* harmony import */ var _loading_loading_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../loading/loading.component */ 4292);







function CameraAccessComponent_0_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    const _r5 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](0, "div", 2)(1, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](2, "lottie-player", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](3, "p", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](5, "p", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](6);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](7, "div", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](8, "div", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](9, "div", 9)(10, "zenid-button", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function CameraAccessComponent_0_ng_template_0_Template_zenid_button_click_10_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r5); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r4.onOk()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](11);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()();
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](12, "div", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementStart"](13, "div", 12)(14, "zenid-button", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵlistener"]("click", function CameraAccessComponent_0_ng_template_0_Template_zenid_button_click_14_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵrestoreView"](_r5); const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2); return _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵresetView"](ctx_r6.onOk()); });
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelementEnd"]()()()();
} if (rf & 2) {
    const t_r3 = ctx.$implicit;
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r3("cameraAccess.title"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r3("cameraAccess.desc"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r3("cameraAccess.submitButton"), " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtextInterpolate1"](" ", t_r3("cameraAccess.submitButton"), " ");
} }
function CameraAccessComponent_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, CameraAccessComponent_0_ng_template_0_Template, 16, 5, "ng-template", 1);
} }
function CameraAccessComponent_zenid_loading_1_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵelement"](0, "zenid-loading");
} }
class CameraAccessComponent {
    constructor(uiService, sdkService) {
        this.uiService = uiService;
        this.sdkService = sdkService;
        this.cameraTested = true;
        this.animationSrc = JSON.stringify(this.uiService.animations['camera']);
    }
    onOk() {
        this.cameraTested = false;
        this.sdkService.testCamera().subscribe({
            next: () => {
                this.cameraTested = true;
                this.sdkService.testCameraOk();
            },
            error: () => {
                this.cameraTested = true;
                this.sdkService.testCameraOk();
                // TODO: handle testCameraError
            }
        });
    }
}
CameraAccessComponent.ɵfac = function CameraAccessComponent_Factory(t) { return new (t || CameraAccessComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService), _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdirectiveInject"]('SdkService')); };
CameraAccessComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵdefineComponent"]({ type: CameraAccessComponent, selectors: [["zenid-access"]], decls: 2, vars: 2, consts: [[4, "ngIf"], ["transloco", ""], [1, "main-wrapper"], [1, "main-container"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"], [1, "mb-6", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01"], [1, "mb-6", "text-s13", "font-normal", "text-light-base-02", "dark:text-dark-base-02", "sm:mb-10", "sm:px-20"], [1, "hidden", "flex-row", "sm:flex"], [1, "flex", "basis-1/2", "justify-start"], [1, "flex", "basis-1/2", "justify-end"], ["classes", "primary-button", 3, "click"], [1, "grow", "sm:hidden"], [1, "block", "sm:hidden"], ["classes", "primary-button w-full", 3, "click"]], template: function CameraAccessComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](0, CameraAccessComponent_0_Template, 1, 0, null, 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵtemplate"](1, CameraAccessComponent_zenid_loading_1_Template, 1, 0, "zenid-loading", 0);
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", ctx.cameraTested);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_3__["ɵɵproperty"]("ngIf", !ctx.cameraTested);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_4__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_5__.TranslocoDirective, _form_button_button_component__WEBPACK_IMPORTED_MODULE_1__.ButtonComponent, _loading_loading_component__WEBPACK_IMPORTED_MODULE_2__.LoadingComponent], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJjYW1lcmEtYWNjZXNzLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 7942:
/*!****************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/button/button.component.ts ***!
  \****************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ButtonComponent": () => (/* binding */ ButtonComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ 4666);


function ButtonComponent_i_2_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "i", 1);
} }
const _c0 = ["*"];
class ButtonComponent {
    constructor() {
        this.classes = '';
        this.withIcon = false;
    }
}
ButtonComponent.ɵfac = function ButtonComponent_Factory(t) { return new (t || ButtonComponent)(); };
ButtonComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: ButtonComponent, selectors: [["zenid-button"]], inputs: { classes: "classes", withIcon: "withIcon" }, ngContentSelectors: _c0, decls: 3, vars: 4, consts: [["class", "ci-check_all", 4, "ngIf"], [1, "ci-check_all"]], template: function ButtonComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵprojectionDef"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "button");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵprojection"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](2, ButtonComponent_i_2_Template, 1, 0, "i", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassMap"](ctx.classes);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.withIcon);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_1__.NgIf], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJidXR0b24uY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 4325:
/*!**************************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-checkbox/input-checkbox.component.ts ***!
  \**************************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputCheckboxComponent": () => (/* binding */ InputCheckboxComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../input.component */ 902);





class InputCheckboxComponent extends _input_component__WEBPACK_IMPORTED_MODULE_0__.InputComponent {
    constructor(injector) {
        super(injector);
    }
}
InputCheckboxComponent.ɵfac = function InputCheckboxComponent_Factory(t) { return new (t || InputCheckboxComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputCheckboxComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputCheckboxComponent, selectors: [["zenid-input-checkbox"]], features: [_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_1__.forwardRef)(() => InputCheckboxComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵInheritDefinitionFeature"]], decls: 8, vars: 4, consts: [[1, "flex", "cursor-pointer", "items-center", "rounded-sm", "px-0", "py-4", "dark:border-dark-paper", "sm:border", "sm:border-light-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00", 3, "for"], [1, "text-s15", "text-light-base-01", "dark:text-dark-base-01"], [1, "grow"], [1, "relative"], ["type", "checkbox", 1, "peer", "sr-only", 3, "id", "ngModel", "ngModelChange", "blur"], [1, "block", "h-7", "w-12", "rounded-full", "bg-light-gray-01", "peer-checked:bg-light-base-00", "dark:bg-dark-gray-01", "dark:peer-checked:bg-dark-base-00"], [1, "absolute", "left-1", "top-1", "h-5", "w-5", "rounded-full", "bg-light-base-contrast", "transition", "peer-checked:translate-x-full", "dark:bg-dark-base-contrast"]], template: function InputCheckboxComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "label", 0)(1, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](3, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "div", 3)(5, "input", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("ngModelChange", function InputCheckboxComponent_Template_input_ngModelChange_5_listener($event) { return ctx.value = $event; })("ngModelChange", function InputCheckboxComponent_Template_input_ngModelChange_5_listener($event) { return ctx.onChange($event); })("blur", function InputCheckboxComponent_Template_input_blur_5_listener($event) { return ctx.onTouched($event); });
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](6, "div", 5)(7, "div", 6);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("for", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](ctx.label);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("id", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngModel", ctx.value);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_2__.CheckboxControlValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgModel], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbnB1dC1jaGVja2JveC5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 9408:
/*!********************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-color/input-color.component.ts ***!
  \********************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputColorComponent": () => (/* binding */ InputColorComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../input.component */ 902);





class InputColorComponent extends _input_component__WEBPACK_IMPORTED_MODULE_0__.InputComponent {
    constructor(injector) {
        super(injector);
    }
}
InputColorComponent.ɵfac = function InputColorComponent_Factory(t) { return new (t || InputColorComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputColorComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputColorComponent, selectors: [["zenid-input-color"]], features: [_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_1__.forwardRef)(() => InputColorComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵInheritDefinitionFeature"]], decls: 10, vars: 5, consts: [[1, "flex", "flex-row", "rounded-sm", "py-2", "px-0", "dark:border-dark-paper", "sm:border", "sm:border-light-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00"], [1, "flex", "items-center", "text-s15", "text-light-base-01", "dark:text-dark-base-01", 3, "for"], [1, "grow"], [1, "flex", "h-[34px]", "w-[114px]", "flex-row", "items-center", "justify-start", "rounded-sm", "bg-light-gray-01", "p-1", "dark:bg-dark-gray-01"], ["type", "color", 1, "h-[26px]", "w-[26px]", "cursor-pointer", "bg-light-gray-01", "dark:bg-dark-gray-01", 3, "id", "ngModel", "ngModelChange", "blur"], [1, "text-s13", "text-light-base-01", "dark:text-dark-base-01"]], template: function InputColorComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 0)(1, "label", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](3, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "div", 3)(5, "input", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("ngModelChange", function InputColorComponent_Template_input_ngModelChange_5_listener($event) { return ctx.value = $event; })("ngModelChange", function InputColorComponent_Template_input_ngModelChange_5_listener($event) { return ctx.onChange($event); })("blur", function InputColorComponent_Template_input_blur_5_listener($event) { return ctx.onTouched($event); });
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](6, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](7, "span", 5);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](8);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](9, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("for", "", ctx.control.name, "-input");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](ctx.label);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("id", "", ctx.control.name, "-input");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngModel", ctx.value);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](ctx.value);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_2__.DefaultValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgModel], styles: ["input[type=color][_ngcontent-%COMP%]::-webkit-color-swatch-wrapper {\n\n    padding: 0px\n}\n\n[_ngcontent-%COMP%]::-webkit-color-swatch {\n\n    border-radius: 0.25rem;\n\n    border-width: 1px;\n\n    --tw-border-opacity: 1;\n\n    border-color: rgb(125 135 143 / var(--tw-border-opacity))\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImlucHV0LWNvbG9yLmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUNJOztJQUFBO0FBQUE7O0FBSUE7O0lBQUEsc0JBQUE7O0lBQUEsaUJBQUE7O0lBQUEsc0JBQUE7O0lBQUE7QUFBQSIsImZpbGUiOiJpbnB1dC1jb2xvci5jb21wb25lbnQuc2NzcyIsInNvdXJjZXNDb250ZW50IjpbImlucHV0W3R5cGU9J2NvbG9yJ106Oi13ZWJraXQtY29sb3Itc3dhdGNoLXdyYXBwZXIge1xuICAgIEBhcHBseSBwLTA7XG59XG5cbjo6LXdlYmtpdC1jb2xvci1zd2F0Y2gge1xuICAgIEBhcHBseSByb3VuZGVkLXNtIGJvcmRlciBib3JkZXItbGlnaHQtYmFzZS0wMjtcbn1cbiJdfQ== */"] });


/***/ }),

/***/ 8007:
/*!**********************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-number/input-number.component.ts ***!
  \**********************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputNumberComponent": () => (/* binding */ InputNumberComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../input.component */ 902);





class InputNumberComponent extends _input_component__WEBPACK_IMPORTED_MODULE_0__.InputComponent {
    constructor(injector) {
        super(injector);
    }
}
InputNumberComponent.ɵfac = function InputNumberComponent_Factory(t) { return new (t || InputNumberComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputNumberComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputNumberComponent, selectors: [["zenid-input-number"]], features: [_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_1__.forwardRef)(() => InputNumberComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵInheritDefinitionFeature"]], decls: 4, vars: 4, consts: [[1, "flex", "cursor-pointer", "flex-col", "rounded-sm", "border", "border-light-paper", "px-0", "py-4", "text-left", "dark:border-dark-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00", 3, "for"], [1, "mb-4", "text-s15", "text-light-base-02", "dark:text-dark-base-02"], ["type", "number", 1, "rounded-t-sm", "border-b", "border-light-action-01", "bg-light-action-00", "px-3", "py-4", "text-s15", "text-light-base-02", "dark:border-dark-action-01", "dark:bg-dark-action-00", "dark:text-dark-base-02", 3, "id", "ngModel", "ngModelChange", "blur"]], template: function InputNumberComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "label", 0)(1, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](3, "input", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("ngModelChange", function InputNumberComponent_Template_input_ngModelChange_3_listener($event) { return ctx.value = $event; })("ngModelChange", function InputNumberComponent_Template_input_ngModelChange_3_listener($event) { return ctx.onChange($event); })("blur", function InputNumberComponent_Template_input_blur_3_listener($event) { return ctx.onTouched($event); });
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("for", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](ctx.label);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("id", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngModel", ctx.value);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_2__.DefaultValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NumberValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgModel], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbnB1dC1udW1iZXIuY29tcG9uZW50LnNjc3MifQ== */"] });


/***/ }),

/***/ 977:
/*!********************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-radio/input-radio.component.ts ***!
  \********************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputRadioComponent": () => (/* binding */ InputRadioComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../input.component */ 902);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ 4666);






function InputRadioComponent_label_1_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "label", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](3, "input", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("ngModelChange", function InputRadioComponent_label_1_Template_input_ngModelChange_3_listener($event) { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r2.value = $event); })("ngModelChange", function InputRadioComponent_label_1_Template_input_ngModelChange_3_listener($event) { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r4 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r4.onChange($event)); })("blur", function InputRadioComponent_label_1_Template_input_blur_3_listener($event) { _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵrestoreView"](_r3); const ctx_r5 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](); return _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵresetView"](ctx_r5.onTouched($event)); });
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
} if (rf & 2) {
    const option_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate1"](" ", option_r1.label, " ");
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate"]("name", ctx_r0.control.name);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate"]("value", option_r1.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngModel", ctx_r0.value);
} }
class InputRadioComponent extends _input_component__WEBPACK_IMPORTED_MODULE_0__.InputComponent {
    constructor(injector) {
        super(injector);
    }
}
InputRadioComponent.ɵfac = function InputRadioComponent_Factory(t) { return new (t || InputRadioComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputRadioComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputRadioComponent, selectors: [["zenid-input-radio"]], inputs: { options: "options" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_1__.forwardRef)(() => InputRadioComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵInheritDefinitionFeature"]], decls: 2, vars: 1, consts: [[1, "flex", "flex-col", "text-s15"], ["class", "flex cursor-pointer items-center rounded-sm px-0 py-4 text-light-base-01 dark:border-dark-paper dark:text-dark-base-01 sm:border sm:border-light-paper sm:px-4 sm:hover:border-light-gray-01 sm:hover:bg-light-gray-00 dark:sm:hover:border-dark-gray-01 dark:sm:hover:bg-dark-gray-00", 4, "ngFor", "ngForOf"], [1, "flex", "cursor-pointer", "items-center", "rounded-sm", "px-0", "py-4", "text-light-base-01", "dark:border-dark-paper", "dark:text-dark-base-01", "sm:border", "sm:border-light-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00"], [1, "grow"], ["type", "radio", "checked", "checked", 1, "peer", "sr-only", 3, "name", "value", "ngModel", "ngModelChange", "blur"], [1, "h-5", "w-5", "rounded-full", "bg-light-gray-01", "peer-checked:border-4", "peer-checked:border-light-base-00", "peer-checked:bg-light-base-contrast", "dark:bg-dark-gray-01", "dark:peer-checked:border-dark-base-00", "dark:peer-checked:bg-dark-base-contrast"]], template: function InputRadioComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](1, InputRadioComponent_label_1_Template, 5, 4, "label", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngForOf", ctx.options);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_3__.NgForOf, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.DefaultValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.RadioControlValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgModel], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJpbnB1dC1yYWRpby5jb21wb25lbnQuc2NzcyJ9 */"] });


/***/ }),

/***/ 7707:
/*!********************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-range/input-range.component.ts ***!
  \********************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputRangeComponent": () => (/* binding */ InputRangeComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! rxjs */ 228);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! rxjs */ 8951);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../input.component */ 902);







const _c0 = ["input"];
class InputRangeComponent extends _input_component__WEBPACK_IMPORTED_MODULE_1__.InputComponent {
    constructor(injector) {
        super(injector);
        this.destroy$ = new rxjs__WEBPACK_IMPORTED_MODULE_2__.Subject();
        this.min = 0;
        this.max = 100;
    }
    ngAfterViewInit() {
        this.control.valueChanges?.pipe((0,rxjs__WEBPACK_IMPORTED_MODULE_3__.takeUntil)(this.destroy$)).subscribe((value) => {
            this.updateColors(value);
        });
        this.switchDarkModeColors();
    }
    switchDarkModeColors() {
        if ((0,_zenid_util__WEBPACK_IMPORTED_MODULE_0__.isDarkMode)()) {
            this.primaryColor = 'var(--dark-primary-color)';
            this.secondaryColor = 'var(--dark-secondary-color)';
        }
        else {
            this.primaryColor = 'var(--primary-color)';
            this.secondaryColor = 'var(--secondary-color)';
        }
        this.updateColors(this.control.value);
    }
    updateColors(value) {
        const val = ((value - this.min) / (this.max - this.min)) * 100;
        const backgroundStyle = `background: linear-gradient(to right, ${this.primaryColor} 0%, ${this.primaryColor} ${val}%, 
            ${this.secondaryColor} ${val}%, ${this.secondaryColor} 100%)`;
        this.el.nativeElement.setAttribute('style', backgroundStyle);
    }
    ngOnDestroy() {
        this.destroy$.next(true);
        this.destroy$.unsubscribe();
    }
}
InputRangeComponent.ɵfac = function InputRangeComponent_Factory(t) { return new (t || InputRangeComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_4__.Injector)); };
InputRangeComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵdefineComponent"]({ type: InputRangeComponent, selectors: [["zenid-input-range"]], viewQuery: function InputRangeComponent_Query(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵviewQuery"](_c0, 5);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵloadQuery"]()) && (ctx.el = _t.first);
    } }, hostBindings: function InputRangeComponent_HostBindings(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("triggerDarkMode", function InputRangeComponent_triggerDarkMode_HostBindingHandler() { return ctx.switchDarkModeColors(); }, false, _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵresolveWindow"]);
    } }, inputs: { min: "min", max: "max" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_5__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_4__.forwardRef)(() => InputRangeComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵInheritDefinitionFeature"]], decls: 14, vars: 7, consts: [[1, "flex", "flex-col", "rounded-sm", "px-0", "pt-4", "pb-7", "dark:border-dark-paper", "sm:border", "sm:border-light-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00"], [1, "mb-4", "flex", "flex-row"], [1, "text-left", "text-s15", "text-light-base-02", "dark:text-dark-base-02", 3, "for"], [1, "grow"], [1, "text-s15", "text-light-base-00", "dark:text-dark-base-00"], [1, "flex", "flex-row", "items-center"], [1, "text-s13", "text-light-base-02", "dark:text-dark-base-02"], ["type", "range", "min", "1", "max", "100", "step", "1", 1, "mx-4", "h-1", "w-full", "cursor-pointer", "rounded", 3, "id", "ngModel", "ngModelChange", "blur"], ["input", ""], [1, "ml-4", "text-s13", "text-light-base-02", "dark:text-dark-base-02"]], template: function InputRangeComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](0, "div", 0)(1, "div", 1)(2, "label", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelement"](4, "div", 3);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](5, "span", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](6);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()();
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](7, "div", 5)(8, "p", 6);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](9);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](10, "input", 7, 8);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵlistener"]("ngModelChange", function InputRangeComponent_Template_input_ngModelChange_10_listener($event) { return ctx.value = $event; })("ngModelChange", function InputRangeComponent_Template_input_ngModelChange_10_listener($event) { return ctx.onChange($event); })("blur", function InputRangeComponent_Template_input_blur_10_listener($event) { return ctx.onTouched($event); });
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementStart"](12, "p", 9);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtext"](13);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵelementEnd"]()()();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate1"]("for", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", ctx.label, " ");
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate1"](" ", ctx.value, " % ");
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate"](ctx.min);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵpropertyInterpolate1"]("id", "input-", ctx.control.name, "-id");
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵproperty"]("ngModel", ctx.value);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵadvance"](3);
        _angular_core__WEBPACK_IMPORTED_MODULE_4__["ɵɵtextInterpolate"](ctx.max);
    } }, dependencies: [_angular_forms__WEBPACK_IMPORTED_MODULE_5__.DefaultValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.RangeValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_5__.NgModel], styles: ["input[type=range][_ngcontent-%COMP%] {\n  -webkit-appearance: none;\n}\ninput[type=range][_ngcontent-%COMP%]::-webkit-slider-thumb {\n  -webkit-appearance: none;\n          appearance: none;\n  width: 28px;\n  height: 28px;\n  background: #FFFFFF;\n  cursor: pointer;\n  box-shadow: 0px 0.5px 4px rgba(0, 0, 0, 0.12), 0px 6px 13px rgba(0, 0, 0, 0.12);\n  border-radius: 9999px;\n}\ninput[type=range][_ngcontent-%COMP%]::-moz-range-thumb {\n  width: 28px;\n  height: 28px;\n  background: #FFFFFF;\n  cursor: pointer;\n  box-shadow: 0px 0.5px 4px rgba(0, 0, 0, 0.12), 0px 6px 13px rgba(0, 0, 0, 0.12);\n  border-radius: 9999px;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImlucHV0LXJhbmdlLmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUNBO0VBQ0ksd0JBQUE7QUFBSjtBQUVJO0VBQ0ksd0JBQUE7VUFBQSxnQkFBQTtFQUNBLFdBQUE7RUFDQSxZQUFBO0VBQ0EsbUJBQUE7RUFDQSxlQUFBO0VBQ0EsK0VBQUE7RUFDQSxxQkFBQTtBQUFSO0FBR0k7RUFDSSxXQUFBO0VBQ0EsWUFBQTtFQUNBLG1CQUFBO0VBQ0EsZUFBQTtFQUNBLCtFQUFBO0VBQ0EscUJBQUE7QUFEUiIsImZpbGUiOiJpbnB1dC1yYW5nZS5jb21wb25lbnQuc2NzcyIsInNvdXJjZXNDb250ZW50IjpbIi8vIGlucHV0W3R5cGU9J3JhbmdlJ10ge1xuaW5wdXRbdHlwZT0ncmFuZ2UnXSB7XG4gICAgLXdlYmtpdC1hcHBlYXJhbmNlOiBub25lO1xuXG4gICAgJjo6LXdlYmtpdC1zbGlkZXItdGh1bWIge1xuICAgICAgICBhcHBlYXJhbmNlOiBub25lO1xuICAgICAgICB3aWR0aDogMjhweDtcbiAgICAgICAgaGVpZ2h0OiAyOHB4O1xuICAgICAgICBiYWNrZ3JvdW5kOiB0aGVtZSgnY29sb3JzLmxpZ2h0LnBhcGVyJyk7XG4gICAgICAgIGN1cnNvcjogcG9pbnRlcjtcbiAgICAgICAgYm94LXNoYWRvdzogMHB4IDAuNXB4IDRweCByZ2JhKDAsIDAsIDAsIDAuMTIpLCAwcHggNnB4IDEzcHggcmdiYSgwLCAwLCAwLCAwLjEyKTsgLy8gVE9ETzogc2V0IGxpa2UgdGhpczogYm94LXNoYWRvdzogdGhlbWUoJ2Ryb3BTaGFkb3cubWQnKTtcbiAgICAgICAgYm9yZGVyLXJhZGl1czogdGhlbWUoJ2JvcmRlclJhZGl1cy5mdWxsJyk7XG4gICAgfVxuXG4gICAgJjo6LW1vei1yYW5nZS10aHVtYiB7XG4gICAgICAgIHdpZHRoOiAyOHB4O1xuICAgICAgICBoZWlnaHQ6IDI4cHg7XG4gICAgICAgIGJhY2tncm91bmQ6IHRoZW1lKCdjb2xvcnMubGlnaHQucGFwZXInKTtcbiAgICAgICAgY3Vyc29yOiBwb2ludGVyO1xuICAgICAgICBib3gtc2hhZG93OiAwcHggMC41cHggNHB4IHJnYmEoMCwgMCwgMCwgMC4xMiksIDBweCA2cHggMTNweCByZ2JhKDAsIDAsIDAsIDAuMTIpOyAvLyBUT0RPOiBzZXQgbGlrZSB0aGlzOiBib3gtc2hhZG93OiB0aGVtZSgnZHJvcFNoYWRvdy5tZCcpO1xuICAgICAgICBib3JkZXItcmFkaXVzOiB0aGVtZSgnYm9yZGVyUmFkaXVzLmZ1bGwnKTtcbiAgICB9XG59XG4iXX0= */"] });


/***/ }),

/***/ 5278:
/*!**********************************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input-select/input-select.component.ts ***!
  \**********************************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputSelectComponent": () => (/* binding */ InputSelectComponent)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _input_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../input.component */ 902);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ 4666);






function InputSelectComponent_option_5_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "option", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
} if (rf & 2) {
    const value_r1 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("value", value_r1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](value_r1);
} }
class InputSelectComponent extends _input_component__WEBPACK_IMPORTED_MODULE_0__.InputComponent {
    constructor(injector) {
        super(injector);
    }
}
InputSelectComponent.ɵfac = function InputSelectComponent_Factory(t) { return new (t || InputSelectComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputSelectComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputSelectComponent, selectors: [["zenid-input-select"]], inputs: { codelist: "codelist" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵProvidersFeature"]([
            {
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NG_VALUE_ACCESSOR,
                useExisting: (0,_angular_core__WEBPACK_IMPORTED_MODULE_1__.forwardRef)(() => InputSelectComponent),
                multi: true
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵInheritDefinitionFeature"]], decls: 6, vars: 5, consts: [[1, "flex", "cursor-pointer", "flex-row", "rounded-sm", "py-1.5", "px-0", "dark:border-dark-paper", "sm:border", "sm:border-light-paper", "sm:px-4", "sm:hover:border-light-gray-01", "sm:hover:bg-light-gray-00", "dark:sm:hover:border-dark-gray-01", "dark:sm:hover:bg-dark-gray-00"], [1, "flex", "items-center", "text-s15", "text-light-base-01", "dark:text-dark-base-01", 3, "for"], [1, "grow"], [1, "cursor-pointer", "rounded-t-sm", "border-b-2", "border-light-action-01", "bg-light-action-00", "px-3", "py-2", "text-light-base-02", "dark:border-dark-action-01", "dark:bg-dark-action-00", "dark:text-dark-base-02", 3, "id", "ngModel", "ngModelChange", "blur"], [3, "value", 4, "ngFor", "ngForOf"], [3, "value"]], template: function InputSelectComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 0)(1, "label", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](3, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "select", 3);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵlistener"]("ngModelChange", function InputSelectComponent_Template_select_ngModelChange_4_listener($event) { return ctx.value = $event; })("ngModelChange", function InputSelectComponent_Template_select_ngModelChange_4_listener($event) { return ctx.onChange($event); })("blur", function InputSelectComponent_Template_select_blur_4_listener($event) { return ctx.onTouched($event); });
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](5, InputSelectComponent_option_5_Template, 2, 2, "option", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("for", "", ctx.control.name, "-input");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](ctx.label);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate1"]("id", "", ctx.control.name, "-input");
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngModel", ctx.value);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngForOf", ctx.codelist);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_3__.NgForOf, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgSelectOption, _angular_forms__WEBPACK_IMPORTED_MODULE_2__["ɵNgSelectMultipleOption"], _angular_forms__WEBPACK_IMPORTED_MODULE_2__.SelectControlValueAccessor, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgControlStatus, _angular_forms__WEBPACK_IMPORTED_MODULE_2__.NgModel], styles: ["select[_ngcontent-%COMP%] {\n  width: 220px;\n  height: 39px;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImlucHV0LXNlbGVjdC5jb21wb25lbnQuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNJLFlBQUE7RUFDQSxZQUFBO0FBQ0oiLCJmaWxlIjoiaW5wdXQtc2VsZWN0LmNvbXBvbmVudC5zY3NzIiwic291cmNlc0NvbnRlbnQiOlsic2VsZWN0IHtcbiAgICB3aWR0aDogMjIwcHg7XG4gICAgaGVpZ2h0OiAzOXB4O1xufVxuIl19 */"] });


/***/ }),

/***/ 902:
/*!**************************************************************!*\
  !*** ./libs/ui/src/lib/common/form/input/input.component.ts ***!
  \**************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "InputComponent": () => (/* binding */ InputComponent)
/* harmony export */ });
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);



class InputComponent {
    constructor(injector) {
        this.injector = injector;
    }
    ngOnInit() {
        this.control = this.injector.get(_angular_forms__WEBPACK_IMPORTED_MODULE_0__.NgControl);
    }
    writeValue(value) {
        this.value = value;
    }
    registerOnChange(fn) {
        this.onChange = fn;
    }
    registerOnTouched(fn) {
        this.onTouched = fn;
    }
}
InputComponent.ɵfac = function InputComponent_Factory(t) { return new (t || InputComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.Injector)); };
InputComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: InputComponent, selectors: [["ng-component"]], inputs: { label: "label" }, decls: 0, vars: 0, template: function InputComponent_Template(rf, ctx) { }, encapsulation: 2 });


/***/ }),

/***/ 4292:
/*!*************************************************************!*\
  !*** ./libs/ui/src/lib/common/loading/loading.component.ts ***!
  \*************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "LoadingComponent": () => (/* binding */ LoadingComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @ngneat/transloco */ 3091);





function LoadingComponent_ng_template_0_lottie_player_3_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](0, "lottie-player", 6);
} if (rf & 2) {
    const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵpropertyInterpolate"]("src", ctx_r2.animationSrc);
} }
function LoadingComponent_ng_template_0_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](0, "div", 1)(1, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](2, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](3, LoadingComponent_ng_template_0_lottie_player_3_Template, 1, 1, "lottie-player", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementStart"](4, "span", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtext"](5);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelement"](6, "div", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵelementEnd"]()();
} if (rf & 2) {
    const t_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵproperty"]("ngIf", ctx_r0.animationSrc);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtextInterpolate"](t_r1("loading.title"));
} }
class LoadingComponent {
    constructor(uiService) {
        this.uiService = uiService;
        this.animationSrc = JSON.stringify(this.uiService.animations['loading']);
    }
}
LoadingComponent.ɵfac = function LoadingComponent_Factory(t) { return new (t || LoadingComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService)); };
LoadingComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: LoadingComponent, selectors: [["zenid-loading"]], decls: 1, vars: 0, consts: [["transloco", ""], [1, "main-wrapper"], [1, "main-container"], [1, "grow"], ["autoplay", "", "loop", "", "mode", "normal", "class", "h-fit sm:h-40", 3, "src", 4, "ngIf"], [1, "text-center", "text-s17", "font-bold", "text-light-base-01", "dark:text-dark-base-01", "sm:mb-20"], ["autoplay", "", "loop", "", "mode", "normal", 1, "h-fit", "sm:h-40", 3, "src"]], template: function LoadingComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵtemplate"](0, LoadingComponent_ng_template_0_Template, 7, 2, "ng-template", 0);
    } }, dependencies: [_angular_common__WEBPACK_IMPORTED_MODULE_2__.NgIf, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_3__.TranslocoDirective], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJsb2FkaW5nLmNvbXBvbmVudC5zY3NzIn0= */"] });


/***/ }),

/***/ 5730:
/*!*********************************************************!*\
  !*** ./libs/ui/src/lib/common/modal/modal.component.ts ***!
  \*********************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ModalComponent": () => (/* binding */ ModalComponent)
/* harmony export */ });
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ 2560);




const _c0 = ["modal"];
class ModalComponent {
    constructor(el, uiService) {
        this.el = el;
        this.uiService = uiService;
        this.element = this.el.nativeElement;
    }
    ngOnInit() {
        // move element to bottom of page (just before </body>) so it can be displayed above everything else
        document.body.appendChild(this.element);
        // add self (this modal instance) to the modal service so it's accessible from controllers
        this.uiService.addModal(this);
    }
    open() {
        document.body.style.top = `-${window.scrollY}px`;
        document.body.classList.add('fixed');
        this.modal.nativeElement.classList.remove('hidden');
        // timeout set to 100 in order to css transition work when calling openModal() in another setTimeout
        setTimeout(() => (this.opened = true), 100);
    }
    close() {
        const scrollY = document.body.style.top;
        document.body.classList.remove('fixed');
        document.body.style.top = '';
        window.scrollTo(0, parseInt(scrollY || '0') * -1);
        this.opened = false;
        setTimeout(() => {
            this.modal.nativeElement.classList.add('hidden');
        }, 300);
    }
    ngOnDestroy() {
        this.uiService.removeModal(this.id);
        this.element.remove();
    }
}
ModalComponent.ɵfac = function ModalComponent_Factory(t) { return new (t || ModalComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_1__.ElementRef), _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdirectiveInject"](_zenid_data_access__WEBPACK_IMPORTED_MODULE_0__.UiService)); };
ModalComponent.ɵcmp = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵdefineComponent"]({ type: ModalComponent, selectors: [["ng-component"]], viewQuery: function ModalComponent_Query(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵviewQuery"](_c0, 5);
    } if (rf & 2) {
        let _t;
        _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵqueryRefresh"](_t = _angular_core__WEBPACK_IMPORTED_MODULE_1__["ɵɵloadQuery"]()) && (ctx.modal = _t.first);
    } }, inputs: { id: "id" }, decls: 0, vars: 0, template: function ModalComponent_Template(rf, ctx) { }, encapsulation: 2 });


/***/ }),

/***/ 6546:
/*!**************************************!*\
  !*** ./libs/ui/src/lib/ui.module.ts ***!
  \**************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "AlertTypesEnum": () => (/* reexport safe */ _common_alert_alert_component__WEBPACK_IMPORTED_MODULE_8__.AlertTypesEnum),
/* harmony export */   "AnalyzingComponent": () => (/* reexport safe */ _common_analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_10__.AnalyzingComponent),
/* harmony export */   "CameraAccessComponent": () => (/* reexport safe */ _common_camera_access_camera_access_component__WEBPACK_IMPORTED_MODULE_11__.CameraAccessComponent),
/* harmony export */   "ModalComponent": () => (/* reexport safe */ _common_modal_modal_component__WEBPACK_IMPORTED_MODULE_14__.ModalComponent),
/* harmony export */   "UiModule": () => (/* binding */ UiModule)
/* harmony export */ });
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_16__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _common_form_button_button_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./common/form/button/button.component */ 7942);
/* harmony import */ var _common_form_input_input_range_input_range_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./common/form/input/input-range/input-range.component */ 7707);
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_17__ = __webpack_require__(/*! @angular/forms */ 2508);
/* harmony import */ var _common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./common/form/input/input-checkbox/input-checkbox.component */ 4325);
/* harmony import */ var _common_form_input_input_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./common/form/input/input.component */ 902);
/* harmony import */ var _common_form_input_input_color_input_color_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./common/form/input/input-color/input-color.component */ 9408);
/* harmony import */ var _common_form_input_input_select_input_select_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./common/form/input/input-select/input-select.component */ 5278);
/* harmony import */ var _common_form_input_input_radio_input_radio_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./common/form/input/input-radio/input-radio.component */ 977);
/* harmony import */ var _zenid_util__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @zenid/util */ 3118);
/* harmony import */ var _common_alert_alert_component__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ./common/alert/alert.component */ 3929);
/* harmony import */ var _common_loading_loading_component__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ./common/loading/loading.component */ 4292);
/* harmony import */ var _common_analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! ./common/analyzing/analyzing.component */ 1243);
/* harmony import */ var _common_camera_access_camera_access_component__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! ./common/camera-access/camera-access.component */ 7997);
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _common_form_input_input_number_input_number_component__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! ./common/form/input/input-number/input-number.component */ 8007);
/* harmony import */ var _common_modal_modal_component__WEBPACK_IMPORTED_MODULE_14__ = __webpack_require__(/*! ./common/modal/modal.component */ 5730);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_15__ = __webpack_require__(/*! @angular/core */ 2560);


















class UiModule {
}
UiModule.ɵfac = function UiModule_Factory(t) { return new (t || UiModule)(); };
UiModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_15__["ɵɵdefineNgModule"]({ type: UiModule });
UiModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_15__["ɵɵdefineInjector"]({ imports: [_angular_common__WEBPACK_IMPORTED_MODULE_16__.CommonModule, _angular_forms__WEBPACK_IMPORTED_MODULE_17__.FormsModule, _angular_forms__WEBPACK_IMPORTED_MODULE_17__.ReactiveFormsModule, _zenid_util__WEBPACK_IMPORTED_MODULE_7__.UtilModule, _zenid_data_access__WEBPACK_IMPORTED_MODULE_12__.DataAccessModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_15__["ɵɵsetNgModuleScope"](UiModule, { declarations: [_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_0__.ButtonComponent,
        _common_form_input_input_range_input_range_component__WEBPACK_IMPORTED_MODULE_1__.InputRangeComponent,
        _common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_2__.InputCheckboxComponent,
        _common_form_input_input_component__WEBPACK_IMPORTED_MODULE_3__.InputComponent,
        _common_form_input_input_color_input_color_component__WEBPACK_IMPORTED_MODULE_4__.InputColorComponent,
        _common_form_input_input_select_input_select_component__WEBPACK_IMPORTED_MODULE_5__.InputSelectComponent,
        _common_form_input_input_radio_input_radio_component__WEBPACK_IMPORTED_MODULE_6__.InputRadioComponent,
        _common_alert_alert_component__WEBPACK_IMPORTED_MODULE_8__.AlertComponent,
        _common_loading_loading_component__WEBPACK_IMPORTED_MODULE_9__.LoadingComponent,
        _common_analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_10__.AnalyzingComponent,
        _common_camera_access_camera_access_component__WEBPACK_IMPORTED_MODULE_11__.CameraAccessComponent,
        _common_form_input_input_number_input_number_component__WEBPACK_IMPORTED_MODULE_13__.InputNumberComponent,
        _common_modal_modal_component__WEBPACK_IMPORTED_MODULE_14__.ModalComponent], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_16__.CommonModule, _angular_forms__WEBPACK_IMPORTED_MODULE_17__.FormsModule, _angular_forms__WEBPACK_IMPORTED_MODULE_17__.ReactiveFormsModule, _zenid_util__WEBPACK_IMPORTED_MODULE_7__.UtilModule, _zenid_data_access__WEBPACK_IMPORTED_MODULE_12__.DataAccessModule], exports: [_common_form_button_button_component__WEBPACK_IMPORTED_MODULE_0__.ButtonComponent,
        _common_form_input_input_range_input_range_component__WEBPACK_IMPORTED_MODULE_1__.InputRangeComponent,
        _common_form_input_input_checkbox_input_checkbox_component__WEBPACK_IMPORTED_MODULE_2__.InputCheckboxComponent,
        _common_form_input_input_color_input_color_component__WEBPACK_IMPORTED_MODULE_4__.InputColorComponent,
        _common_form_input_input_select_input_select_component__WEBPACK_IMPORTED_MODULE_5__.InputSelectComponent,
        _common_form_input_input_radio_input_radio_component__WEBPACK_IMPORTED_MODULE_6__.InputRadioComponent,
        _common_alert_alert_component__WEBPACK_IMPORTED_MODULE_8__.AlertComponent,
        _common_loading_loading_component__WEBPACK_IMPORTED_MODULE_9__.LoadingComponent,
        _common_analyzing_analyzing_component__WEBPACK_IMPORTED_MODULE_10__.AnalyzingComponent,
        _common_camera_access_camera_access_component__WEBPACK_IMPORTED_MODULE_11__.CameraAccessComponent,
        _common_form_input_input_number_input_number_component__WEBPACK_IMPORTED_MODULE_13__.InputNumberComponent] }); })();






/***/ }),

/***/ 3118:
/*!********************************!*\
  !*** ./libs/util/src/index.ts ***!
  \********************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DOCUMENT_ICONS": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.DOCUMENT_ICONS),
/* harmony export */   "DOCUMENT_ICON_UNI": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.DOCUMENT_ICON_UNI),
/* harmony export */   "FeaturesEnum": () => (/* reexport safe */ _lib_web_settings_model__WEBPACK_IMPORTED_MODULE_1__.FeaturesEnum),
/* harmony export */   "POST_MESSAGE_APP_READY": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.POST_MESSAGE_APP_READY),
/* harmony export */   "TRIGGER_DARK_MODE_EVENT_NAME": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.TRIGGER_DARK_MODE_EVENT_NAME),
/* harmony export */   "UtilModule": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.UtilModule),
/* harmony export */   "disableAnimations": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.disableAnimations),
/* harmony export */   "fadeAnimation": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.fadeAnimation),
/* harmony export */   "getRouterOutletState": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.getRouterOutletState),
/* harmony export */   "isDarkMode": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.isDarkMode),
/* harmony export */   "lightenColor": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.lightenColor),
/* harmony export */   "lowercaseFirstLetter": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.lowercaseFirstLetter),
/* harmony export */   "setCssVar": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.setCssVar),
/* harmony export */   "setThemeColors": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.setThemeColors),
/* harmony export */   "settingsToDocumentSettings": () => (/* reexport safe */ _lib_web_settings_model__WEBPACK_IMPORTED_MODULE_1__.settingsToDocumentSettings),
/* harmony export */   "settingsToSelfieVideoSettings": () => (/* reexport safe */ _lib_web_settings_model__WEBPACK_IMPORTED_MODULE_1__.settingsToSelfieVideoSettings),
/* harmony export */   "triggerDarkMode": () => (/* reexport safe */ _lib_util_module__WEBPACK_IMPORTED_MODULE_0__.triggerDarkMode)
/* harmony export */ });
/* harmony import */ var _lib_util_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./lib/util.module */ 7819);
/* harmony import */ var _lib_web_settings_model__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./lib/web/settings.model */ 1097);




/***/ }),

/***/ 2263:
/*!*****************************************!*\
  !*** ./libs/util/src/lib/animations.ts ***!
  \*****************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "fadeAnimation": () => (/* binding */ fadeAnimation),
/* harmony export */   "getRouterOutletState": () => (/* binding */ getRouterOutletState)
/* harmony export */ });
/* harmony import */ var _angular_animations__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/animations */ 4851);

const fadeAnimation = (0,_angular_animations__WEBPACK_IMPORTED_MODULE_0__.trigger)('fadeAnimation', [
    (0,_angular_animations__WEBPACK_IMPORTED_MODULE_0__.transition)('*=>*', [
        // css styles at start of transition
        (0,_angular_animations__WEBPACK_IMPORTED_MODULE_0__.style)({ opacity: 0 }),
        // animation and styles at end of transition
        (0,_angular_animations__WEBPACK_IMPORTED_MODULE_0__.animate)('300ms', (0,_angular_animations__WEBPACK_IMPORTED_MODULE_0__.style)({ opacity: 1 }))
    ])
]);
const getRouterOutletState = (outlet) => {
    return outlet.isActivated ? outlet.activatedRoute : '';
};


/***/ }),

/***/ 880:
/*!*************************************!*\
  !*** ./libs/util/src/lib/common.ts ***!
  \*************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DOCUMENT_ICONS": () => (/* binding */ DOCUMENT_ICONS),
/* harmony export */   "DOCUMENT_ICON_UNI": () => (/* binding */ DOCUMENT_ICON_UNI),
/* harmony export */   "POST_MESSAGE_APP_READY": () => (/* binding */ POST_MESSAGE_APP_READY),
/* harmony export */   "TRIGGER_DARK_MODE_EVENT_NAME": () => (/* binding */ TRIGGER_DARK_MODE_EVENT_NAME),
/* harmony export */   "disableAnimations": () => (/* binding */ disableAnimations),
/* harmony export */   "isDarkMode": () => (/* binding */ isDarkMode),
/* harmony export */   "lightenColor": () => (/* binding */ lightenColor),
/* harmony export */   "lowercaseFirstLetter": () => (/* binding */ lowercaseFirstLetter),
/* harmony export */   "setCssVar": () => (/* binding */ setCssVar),
/* harmony export */   "setThemeColors": () => (/* binding */ setThemeColors),
/* harmony export */   "triggerDarkMode": () => (/* binding */ triggerDarkMode)
/* harmony export */ });
const TRIGGER_DARK_MODE_EVENT_NAME = 'triggerDarkMode';
const DOCUMENT_ICONS = ['idc', 'drv', 'pas'];
const DOCUMENT_ICON_UNI = 'uni';
const POST_MESSAGE_APP_READY = 'post-message-iframe-app-ready';
/*
 * Animations not working on iOS 12 / 13: animate is undefined
 * https://github.com/angular/angular/issues/45016#issuecomment-1050304540
 */
const disableAnimations = !('animate' in document.documentElement) || (navigator && /iPhone OS (8|9|10|11|12|13)_/.test(navigator.userAgent));
const lowercaseFirstLetter = (string) => {
    return string.charAt(0).toLowerCase() + string.slice(1);
};
const camelCaseToCssDash = (string) => {
    return '--' + string.replace(/[A-Z]/g, (m) => '-' + m.toLowerCase());
};
const setCssVar = (variable, value) => {
    document.documentElement.style.setProperty(variable, value);
};
const setThemeColors = (colors) => {
    Object.keys(colors).forEach((key) => {
        const colorValue = colors[key].toString();
        if (colorValue) {
            const colorName = camelCaseToCssDash(key);
            setCssVar(colorName, colorValue);
        }
    });
};
const triggerDarkMode = (darkMode) => {
    if (darkMode) {
        document.documentElement.classList.add('dark');
    }
    else {
        document.documentElement.classList.remove('dark');
    }
    // dispatch CustomEvent if needed (for example in input-range.component)
    window.dispatchEvent(new CustomEvent(TRIGGER_DARK_MODE_EVENT_NAME));
};
const isDarkMode = () => document.documentElement.classList.contains('dark');
const lightenColor = (color, percent) => {
    const num = parseInt(color.replace('#', ''), 16), amt = Math.round(2.55 * percent), R = (num >> 16) + amt, B = ((num >> 8) & 0x00ff) + amt, G = (num & 0x0000ff) + amt;
    return ('#' +
        (0x1000000 +
            (R < 255 ? (R < 1 ? 0 : R) : 255) * 0x10000 +
            (B < 255 ? (B < 1 ? 0 : B) : 255) * 0x100 +
            (G < 255 ? (G < 1 ? 0 : G) : 255))
            .toString(16)
            .slice(1));
};


/***/ }),

/***/ 7247:
/*!**************************************************************!*\
  !*** ./libs/util/src/lib/transloco/transloco-root.module.ts ***!
  \**************************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "TranslocoHttpLoader": () => (/* binding */ TranslocoHttpLoader),
/* harmony export */   "TranslocoRootModule": () => (/* binding */ TranslocoRootModule),
/* harmony export */   "availableLangs": () => (/* binding */ availableLangs)
/* harmony export */ });
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ 8987);
/* harmony import */ var _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @ngneat/transloco */ 3091);
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ 2560);





const availableLangs = ['en', 'cs', 'sk', 'hu'];
const getDefaultLang = () => {
    let defaultLang;
    navigator.languages.every((language) => {
        defaultLang = availableLangs.find((lang) => {
            return lang === language.toLowerCase().substring(0, 2);
        });
        return defaultLang ? false : true;
    });
    return defaultLang;
};
class TranslocoHttpLoader {
    constructor(http) {
        this.http = http;
    }
    getTranslation(lang) {
        return this.http.get(`/assets/i18n/${lang}.json`);
    }
}
TranslocoHttpLoader.ɵfac = function TranslocoHttpLoader_Factory(t) { return new (t || TranslocoHttpLoader)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_common_http__WEBPACK_IMPORTED_MODULE_1__.HttpClient)); };
TranslocoHttpLoader.ɵprov = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({ token: TranslocoHttpLoader, factory: TranslocoHttpLoader.ɵfac, providedIn: 'root' });
const preloadLang = (transloco) => {
    return () => transloco.load(transloco.getDefaultLang());
};
class TranslocoRootModule {
}
TranslocoRootModule.ɵfac = function TranslocoRootModule_Factory(t) { return new (t || TranslocoRootModule)(); };
TranslocoRootModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: TranslocoRootModule });
TranslocoRootModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({ providers: [
        {
            provide: _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TRANSLOCO_CONFIG,
            useValue: (0,_ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.translocoConfig)({
                availableLangs: availableLangs,
                defaultLang: getDefaultLang() ? getDefaultLang() : 'en',
                reRenderOnLangChange: true,
                prodMode: true
            })
        },
        { provide: _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TRANSLOCO_LOADER, useClass: TranslocoHttpLoader },
        {
            provide: _angular_core__WEBPACK_IMPORTED_MODULE_0__.APP_INITIALIZER,
            multi: true,
            useFactory: preloadLang,
            deps: [_ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TranslocoService]
        }
    ], imports: [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__.HttpClientModule, _ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TranslocoModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](TranslocoRootModule, { imports: [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__.HttpClientModule], exports: [_ngneat_transloco__WEBPACK_IMPORTED_MODULE_2__.TranslocoModule] }); })();


/***/ }),

/***/ 7819:
/*!******************************************!*\
  !*** ./libs/util/src/lib/util.module.ts ***!
  \******************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "DOCUMENT_ICONS": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.DOCUMENT_ICONS),
/* harmony export */   "DOCUMENT_ICON_UNI": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.DOCUMENT_ICON_UNI),
/* harmony export */   "POST_MESSAGE_APP_READY": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.POST_MESSAGE_APP_READY),
/* harmony export */   "TRIGGER_DARK_MODE_EVENT_NAME": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.TRIGGER_DARK_MODE_EVENT_NAME),
/* harmony export */   "UtilModule": () => (/* binding */ UtilModule),
/* harmony export */   "disableAnimations": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.disableAnimations),
/* harmony export */   "fadeAnimation": () => (/* reexport safe */ _animations__WEBPACK_IMPORTED_MODULE_3__.fadeAnimation),
/* harmony export */   "getRouterOutletState": () => (/* reexport safe */ _animations__WEBPACK_IMPORTED_MODULE_3__.getRouterOutletState),
/* harmony export */   "isDarkMode": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.isDarkMode),
/* harmony export */   "lightenColor": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.lightenColor),
/* harmony export */   "lowercaseFirstLetter": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.lowercaseFirstLetter),
/* harmony export */   "setCssVar": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.setCssVar),
/* harmony export */   "setThemeColors": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.setThemeColors),
/* harmony export */   "triggerDarkMode": () => (/* reexport safe */ _common__WEBPACK_IMPORTED_MODULE_1__.triggerDarkMode)
/* harmony export */ });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/core */ 2560);
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @angular/common */ 4666);
/* harmony import */ var _transloco_transloco_root_module__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./transloco/transloco-root.module */ 7247);
/* harmony import */ var _common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./common */ 880);
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @angular/common/http */ 8987);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! rxjs */ 1640);
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! rxjs */ 9337);
/* harmony import */ var _zenid_data_access__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @zenid/data-access */ 9363);
/* harmony import */ var _animations__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./animations */ 2263);









const loadAnimations = (httpClient, utilService) => {
    const animationsToLoad = ['analyzing', 'camera', 'error', 'id-back', 'loading', 'success', 'warning', 'welcome'];
    const obs = {};
    animationsToLoad.forEach((value) => {
        obs[value] = httpClient.get(`/assets/animations/${value}.json`);
    });
    return () => (0,rxjs__WEBPACK_IMPORTED_MODULE_4__.forkJoin)(obs).pipe((0,rxjs__WEBPACK_IMPORTED_MODULE_5__.tap)((animations) => (utilService.animations = animations)));
};
class UtilModule {
}
UtilModule.ɵfac = function UtilModule_Factory(t) { return new (t || UtilModule)(); };
UtilModule.ɵmod = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵdefineNgModule"]({ type: UtilModule });
UtilModule.ɵinj = /*@__PURE__*/ _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵdefineInjector"]({ providers: [{ provide: _angular_core__WEBPACK_IMPORTED_MODULE_6__.APP_INITIALIZER, useFactory: loadAnimations, deps: [_angular_common_http__WEBPACK_IMPORTED_MODULE_7__.HttpClient, _zenid_data_access__WEBPACK_IMPORTED_MODULE_2__.UiService], multi: true }], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_8__.CommonModule, _zenid_data_access__WEBPACK_IMPORTED_MODULE_2__.DataAccessModule, _transloco_transloco_root_module__WEBPACK_IMPORTED_MODULE_0__.TranslocoRootModule] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_6__["ɵɵsetNgModuleScope"](UtilModule, { imports: [_angular_common__WEBPACK_IMPORTED_MODULE_8__.CommonModule, _zenid_data_access__WEBPACK_IMPORTED_MODULE_2__.DataAccessModule], exports: [_transloco_transloco_root_module__WEBPACK_IMPORTED_MODULE_0__.TranslocoRootModule] }); })();



/***/ }),

/***/ 1097:
/*!*************************************************!*\
  !*** ./libs/util/src/lib/web/settings.model.ts ***!
  \*************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "FeaturesEnum": () => (/* binding */ FeaturesEnum),
/* harmony export */   "settingsToDocumentSettings": () => (/* binding */ settingsToDocumentSettings),
/* harmony export */   "settingsToSelfieVideoSettings": () => (/* binding */ settingsToSelfieVideoSettings)
/* harmony export */ });
const settingsToDocumentSettings = (settings) => {
    return {
        feature: FeaturesEnum.DOCUMENT,
        enabledModels: {
            PossibleDocuments: [...settings.DocumentsFilter, { Country: settings.country }]
        },
        visualizer: new Visualizer({ drawText: false }),
        specularAcceptableScore: settings.DocumentsVerifier.specularAcceptableScore,
        documentBlurAcceptableScore: settings.DocumentsVerifier.documentBlurAcceptableScore,
        timeToBlurMaxTolerance: settings.DocumentsVerifier.timeToBlurMaxTolerance,
        readBarcode: settings.DocumentsVerifier.readBarcode,
        showTimer: settings.DocumentsVerifier.showTimer,
        enableAimingCircle: settings.DocumentsVerifier.enableAimingCircle,
        drawOutline: settings.DocumentsVerifier.drawOutline
    };
};
const settingsToSelfieVideoSettings = (settings) => {
    return {
        feature: settings.selfieVerification === FeaturesEnum.SELFIE ? FeaturesEnum.SELFIE : FeaturesEnum.SELFIE_VIDEO,
        enableLegacyMode: settings.selfieVerification === 'livenessLegacy',
        visualizer: new Visualizer({ drawText: false })
    };
};
var FeaturesEnum;
(function (FeaturesEnum) {
    FeaturesEnum["DOCUMENT"] = "document";
    FeaturesEnum["SELFIE"] = "selfie";
    FeaturesEnum["SELFIE_VIDEO"] = "selfieVideo";
})(FeaturesEnum || (FeaturesEnum = {}));


/***/ }),

/***/ 1853:
/*!**************************************************!*\
  !*** ./libs/zenid-web-sdk/src/lib/zenid.enum.ts ***!
  \**************************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ZenidContries": () => (/* binding */ ZenidContries),
/* harmony export */   "ZenidDocumentCodes": () => (/* binding */ ZenidDocumentCodes),
/* harmony export */   "ZenidDocumentRoles": () => (/* binding */ ZenidDocumentRoles),
/* harmony export */   "ZenidFeedback": () => (/* binding */ ZenidFeedback),
/* harmony export */   "ZenidPageCodes": () => (/* binding */ ZenidPageCodes),
/* harmony export */   "ZenidSdkEvents": () => (/* binding */ ZenidSdkEvents),
/* harmony export */   "ZenidSupportedLanguages": () => (/* binding */ ZenidSupportedLanguages),
/* harmony export */   "zenidContriesFull": () => (/* binding */ zenidContriesFull),
/* harmony export */   "zenidModels": () => (/* binding */ zenidModels)
/* harmony export */ });
var ZenidDocumentCodes;
(function (ZenidDocumentCodes) {
    ZenidDocumentCodes[ZenidDocumentCodes["IDC1"] = 0] = "IDC1";
    ZenidDocumentCodes[ZenidDocumentCodes["IDC2"] = 1] = "IDC2";
    ZenidDocumentCodes[ZenidDocumentCodes["DRV"] = 2] = "DRV";
    ZenidDocumentCodes[ZenidDocumentCodes["PAS"] = 3] = "PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_IDC_2008plus"] = 4] = "SK_IDC_2008plus";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_DRV_2004_08_09"] = 5] = "SK_DRV_2004_08_09";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_DRV_2013"] = 6] = "SK_DRV_2013";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_DRV_2015"] = 7] = "SK_DRV_2015";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_PAS_2008_14"] = 8] = "SK_PAS_2008_14";
    ZenidDocumentCodes[ZenidDocumentCodes["SK_DRV_1993"] = 10] = "SK_DRV_1993";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_IDC_2015"] = 11] = "PL_IDC_2015";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_IDC_2010"] = 12] = "DE_IDC_2010";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_IDC_2001"] = 13] = "DE_IDC_2001";
    ZenidDocumentCodes[ZenidDocumentCodes["HR_IDC_2013_15"] = 14] = "HR_IDC_2013_15";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_IDE_2000"] = 15] = "AT_IDE_2000";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_IDC_2000_01_12"] = 16] = "HU_IDC_2000_01_12";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_IDC_2016"] = 17] = "HU_IDC_2016";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_IDC_2002_05_10"] = 18] = "AT_IDC_2002_05_10";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_ADD_2012"] = 19] = "HU_ADD_2012";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_PAS_2006_14"] = 20] = "AT_PAS_2006_14";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_DRV_2006"] = 21] = "AT_DRV_2006";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_DRV_2013"] = 22] = "AT_DRV_2013";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_RES_2011_14"] = 23] = "CZ_RES_2011_14";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_RES_2006_T"] = 24] = "CZ_RES_2006_T";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_RES_2006_07"] = 25] = "CZ_RES_2006_07";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_GUN_2014"] = 26] = "CZ_GUN_2014";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_PAS_2006_12"] = 27] = "HU_PAS_2006_12";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_DRV_2012_13"] = 28] = "HU_DRV_2012_13";
    ZenidDocumentCodes[ZenidDocumentCodes["HU_DRV_2012_B"] = 29] = "HU_DRV_2012_B";
    ZenidDocumentCodes[ZenidDocumentCodes["EU_EHIC_2004_A"] = 30] = "EU_EHIC_2004_A";
    ZenidDocumentCodes[ZenidDocumentCodes["Unknown"] = 31] = "Unknown";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_GUN_2017"] = 32] = "CZ_GUN_2017";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_RES_2020"] = 33] = "CZ_RES_2020";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_IDC_2019"] = 34] = "PL_IDC_2019";
    ZenidDocumentCodes[ZenidDocumentCodes["IT_PAS_2006_10"] = 35] = "IT_PAS_2006_10";
    ZenidDocumentCodes[ZenidDocumentCodes["INT_ISIC_2008"] = 36] = "INT_ISIC_2008";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_PAS"] = 37] = "DE_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["DK_PAS"] = 38] = "DK_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["ES_PAS"] = 39] = "ES_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["FI_PAS"] = 40] = "FI_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["FR_PAS"] = 41] = "FR_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["GB_PAS"] = 42] = "GB_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["IS_PAS"] = 43] = "IS_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["NL_PAS"] = 44] = "NL_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["RO_PAS"] = 45] = "RO_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["SE_PAS"] = 46] = "SE_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_PAS"] = 47] = "PL_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_DRV_2013"] = 48] = "PL_DRV_2013";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_BIRTH"] = 49] = "CZ_BIRTH";
    ZenidDocumentCodes[ZenidDocumentCodes["CZ_VEHICLE_I"] = 50] = "CZ_VEHICLE_I";
    ZenidDocumentCodes[ZenidDocumentCodes["INT_ISIC_2019"] = 51] = "INT_ISIC_2019";
    ZenidDocumentCodes[ZenidDocumentCodes["SI_PAS"] = 52] = "SI_PAS";
    ZenidDocumentCodes[ZenidDocumentCodes["SI_IDC"] = 53] = "SI_IDC";
    ZenidDocumentCodes[ZenidDocumentCodes["SI_DRV"] = 54] = "SI_DRV";
    ZenidDocumentCodes[ZenidDocumentCodes["EU_EHIC_2004_B"] = 55] = "EU_EHIC_2004_B";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_IDC_2001_02_13"] = 56] = "PL_IDC_2001_02_13";
    ZenidDocumentCodes[ZenidDocumentCodes["IT_IDC_2016"] = 57] = "IT_IDC_2016";
    ZenidDocumentCodes[ZenidDocumentCodes["HR_PAS_2009_15"] = 58] = "HR_PAS_2009_15";
    ZenidDocumentCodes[ZenidDocumentCodes["HR_DRV_2013"] = 59] = "HR_DRV_2013";
    ZenidDocumentCodes[ZenidDocumentCodes["HR_IDC_2003"] = 60] = "HR_IDC_2003";
    ZenidDocumentCodes[ZenidDocumentCodes["SI_DRV_2009"] = 61] = "SI_DRV_2009";
    ZenidDocumentCodes[ZenidDocumentCodes["BG_PAS_2010"] = 62] = "BG_PAS_2010";
    ZenidDocumentCodes[ZenidDocumentCodes["BG_IDC_2010"] = 63] = "BG_IDC_2010";
    ZenidDocumentCodes[ZenidDocumentCodes["BG_DRV_2010_13"] = 64] = "BG_DRV_2010_13";
    ZenidDocumentCodes[ZenidDocumentCodes["HR_IDC_2021"] = 65] = "HR_IDC_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["AT_IDC_2021"] = 66] = "AT_IDC_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_PAS_2007"] = 67] = "DE_PAS_2007";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_DRV_2013_21"] = 68] = "DE_DRV_2013_21";
    ZenidDocumentCodes[ZenidDocumentCodes["DE_DRV_1999_01_04_11"] = 69] = "DE_DRV_1999_01_04_11";
    ZenidDocumentCodes[ZenidDocumentCodes["FR_IDC_2021"] = 71] = "FR_IDC_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["FR_IDC_1988_94"] = 72] = "FR_IDC_1988_94";
    ZenidDocumentCodes[ZenidDocumentCodes["ES_PAS_2003_06"] = 73] = "ES_PAS_2003_06";
    ZenidDocumentCodes[ZenidDocumentCodes["ES_IDC_2015"] = 74] = "ES_IDC_2015";
    ZenidDocumentCodes[ZenidDocumentCodes["ES_IDC_2006"] = 75] = "ES_IDC_2006";
    ZenidDocumentCodes[ZenidDocumentCodes["IT_IDC_2004"] = 76] = "IT_IDC_2004";
    ZenidDocumentCodes[ZenidDocumentCodes["RO_IDC_2001_06_09_17_21"] = 77] = "RO_IDC_2001_06_09_17_21";
    ZenidDocumentCodes[ZenidDocumentCodes["NL_IDC_2014_17_21"] = 78] = "NL_IDC_2014_17_21";
    ZenidDocumentCodes[ZenidDocumentCodes["BE_PAS_2014_17_19"] = 79] = "BE_PAS_2014_17_19";
    ZenidDocumentCodes[ZenidDocumentCodes["BE_IDC_2013_15"] = 80] = "BE_IDC_2013_15";
    ZenidDocumentCodes[ZenidDocumentCodes["BE_IDC_2020_21"] = 81] = "BE_IDC_2020_21";
    ZenidDocumentCodes[ZenidDocumentCodes["GR_PAS_2020"] = 82] = "GR_PAS_2020";
    ZenidDocumentCodes[ZenidDocumentCodes["PT_PAS_2006_09"] = 83] = "PT_PAS_2006_09";
    ZenidDocumentCodes[ZenidDocumentCodes["PT_IDC_2007_08_09_15"] = 85] = "PT_IDC_2007_08_09_15";
    ZenidDocumentCodes[ZenidDocumentCodes["SE_IDC_2012_21"] = 86] = "SE_IDC_2012_21";
    ZenidDocumentCodes[ZenidDocumentCodes["FI_IDC_2017_21"] = 87] = "FI_IDC_2017_21";
    ZenidDocumentCodes[ZenidDocumentCodes["IE_PAS_2006_13"] = 88] = "IE_PAS_2006_13";
    ZenidDocumentCodes[ZenidDocumentCodes["LT_PAS_2008_09_11_19"] = 89] = "LT_PAS_2008_09_11_19";
    ZenidDocumentCodes[ZenidDocumentCodes["LT_IDC_2009_12"] = 90] = "LT_IDC_2009_12";
    ZenidDocumentCodes[ZenidDocumentCodes["LV_PAS_2015"] = 91] = "LV_PAS_2015";
    ZenidDocumentCodes[ZenidDocumentCodes["LV_PAS_2007"] = 92] = "LV_PAS_2007";
    ZenidDocumentCodes[ZenidDocumentCodes["LV_IDC_2012"] = 93] = "LV_IDC_2012";
    ZenidDocumentCodes[ZenidDocumentCodes["LV_IDC_2019"] = 94] = "LV_IDC_2019";
    ZenidDocumentCodes[ZenidDocumentCodes["EE_PAS_2014"] = 95] = "EE_PAS_2014";
    ZenidDocumentCodes[ZenidDocumentCodes["EE_PAS_2021"] = 96] = "EE_PAS_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["EE_IDC_2011"] = 97] = "EE_IDC_2011";
    ZenidDocumentCodes[ZenidDocumentCodes["EE_IDC_2018_21"] = 98] = "EE_IDC_2018_21";
    ZenidDocumentCodes[ZenidDocumentCodes["CY_PAS_2010_20"] = 99] = "CY_PAS_2010_20";
    ZenidDocumentCodes[ZenidDocumentCodes["CY_IDC_2000_08"] = 100] = "CY_IDC_2000_08";
    ZenidDocumentCodes[ZenidDocumentCodes["CY_IDC_2015_20"] = 101] = "CY_IDC_2015_20";
    ZenidDocumentCodes[ZenidDocumentCodes["LU_PAS_2015"] = 102] = "LU_PAS_2015";
    ZenidDocumentCodes[ZenidDocumentCodes["LU_IDC_2014_21"] = 103] = "LU_IDC_2014_21";
    ZenidDocumentCodes[ZenidDocumentCodes["LU_IDC_2008_13"] = 104] = "LU_IDC_2008_13";
    ZenidDocumentCodes[ZenidDocumentCodes["MT_PAS_2008"] = 105] = "MT_PAS_2008";
    ZenidDocumentCodes[ZenidDocumentCodes["MT_IDC_2014"] = 106] = "MT_IDC_2014";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_PAS_2011"] = 107] = "PL_PAS_2011";
    ZenidDocumentCodes[ZenidDocumentCodes["PL_DRV_1999"] = 108] = "PL_DRV_1999";
    ZenidDocumentCodes[ZenidDocumentCodes["LT_IDC_2021"] = 109] = "LT_IDC_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["UA_PAS_2007_15"] = 10] = "UA_PAS_2007_15";
    ZenidDocumentCodes[ZenidDocumentCodes["UA_IDC_2017"] = 111] = "UA_IDC_2017";
    ZenidDocumentCodes[ZenidDocumentCodes["EU_VIS_2019"] = 112] = "EU_VIS_2019";
    ZenidDocumentCodes[ZenidDocumentCodes["UA_DRV_2016"] = 113] = "UA_DRV_2016";
    ZenidDocumentCodes[ZenidDocumentCodes["UA_DRV_2005"] = 114] = "UA_DRV_2005";
    ZenidDocumentCodes[ZenidDocumentCodes["UA_DRV_2021"] = 115] = "UA_DRV_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["EU_EHIC_2004_C"] = 116] = "EU_EHIC_2004_C";
    ZenidDocumentCodes[ZenidDocumentCodes["VN_PAS_2005"] = 117] = "VN_PAS_2005";
    ZenidDocumentCodes[ZenidDocumentCodes["NL_DRV_2006"] = 118] = "NL_DRV_2006";
    ZenidDocumentCodes[ZenidDocumentCodes["NL_DRV_2013"] = 119] = "NL_DRV_2013";
    ZenidDocumentCodes[ZenidDocumentCodes["NL_DRV_2014"] = 120] = "NL_DRV_2014";
    ZenidDocumentCodes[ZenidDocumentCodes["AL_PAS_2009"] = 121] = "AL_PAS_2009";
    ZenidDocumentCodes[ZenidDocumentCodes["BA_PAS_2014"] = 122] = "BA_PAS_2014";
    ZenidDocumentCodes[ZenidDocumentCodes["CH_PAS_2010"] = 123] = "CH_PAS_2010";
    ZenidDocumentCodes[ZenidDocumentCodes["ME_PAS_2008"] = 124] = "ME_PAS_2008";
    ZenidDocumentCodes[ZenidDocumentCodes["MK_PAS_2007"] = 125] = "MK_PAS_2007";
    ZenidDocumentCodes[ZenidDocumentCodes["RS_PAS_2008"] = 126] = "RS_PAS_2008";
    ZenidDocumentCodes[ZenidDocumentCodes["NO_PAS_2011_15"] = 127] = "NO_PAS_2011_15";
    ZenidDocumentCodes[ZenidDocumentCodes["NO_PAS_2020"] = 128] = "NO_PAS_2020";
    ZenidDocumentCodes[ZenidDocumentCodes["GB_PAS_2010_11_15_19"] = 129] = "GB_PAS_2010_11_15_19";
    ZenidDocumentCodes[ZenidDocumentCodes["BY_PAS_2006"] = 130] = "BY_PAS_2006";
    ZenidDocumentCodes[ZenidDocumentCodes["BY_PAS_2021"] = 131] = "BY_PAS_2021";
    ZenidDocumentCodes[ZenidDocumentCodes["MD_PAS_2011_14_18"] = 132] = "MD_PAS_2011_14_18";
    ZenidDocumentCodes[ZenidDocumentCodes["IS_PAS_2006"] = 133] = "IS_PAS_2006";
    ZenidDocumentCodes[ZenidDocumentCodes["IN_PAS_2000_13"] = 134] = "IN_PAS_2000_13";
    ZenidDocumentCodes[ZenidDocumentCodes["TR_PAS_2010"] = 135] = "TR_PAS_2010";
    ZenidDocumentCodes[ZenidDocumentCodes["TR_PAS_2018"] = 136] = "TR_PAS_2018";
})(ZenidDocumentCodes || (ZenidDocumentCodes = {}));
var ZenidContries;
(function (ZenidContries) {
    ZenidContries[ZenidContries["Cz"] = 0] = "Cz";
    ZenidContries[ZenidContries["Sk"] = 1] = "Sk";
    ZenidContries[ZenidContries["At"] = 2] = "At";
    ZenidContries[ZenidContries["Hu"] = 3] = "Hu";
    ZenidContries[ZenidContries["Pl"] = 4] = "Pl";
    ZenidContries[ZenidContries["De"] = 5] = "De";
    ZenidContries[ZenidContries["Hr"] = 6] = "Hr";
    ZenidContries[ZenidContries["Ro"] = 7] = "Ro";
    ZenidContries[ZenidContries["Ru"] = 8] = "Ru";
    ZenidContries[ZenidContries["Ua"] = 9] = "Ua";
    ZenidContries[ZenidContries["It"] = 10] = "It";
    ZenidContries[ZenidContries["Dk"] = 11] = "Dk";
    ZenidContries[ZenidContries["Es"] = 12] = "Es";
    ZenidContries[ZenidContries["Fi"] = 13] = "Fi";
    ZenidContries[ZenidContries["Fr"] = 14] = "Fr";
    ZenidContries[ZenidContries["Gb"] = 15] = "Gb";
    ZenidContries[ZenidContries["Is"] = 16] = "Is";
    ZenidContries[ZenidContries["Nl"] = 17] = "Nl";
    ZenidContries[ZenidContries["Se"] = 18] = "Se";
    ZenidContries[ZenidContries["Si"] = 19] = "Si";
    ZenidContries[ZenidContries["Bg"] = 20] = "Bg";
    ZenidContries[ZenidContries["Al"] = 21] = "Al";
    ZenidContries[ZenidContries["Be"] = 23] = "Be";
    ZenidContries[ZenidContries["By"] = 24] = "By";
    ZenidContries[ZenidContries["Ba"] = 25] = "Ba";
    ZenidContries[ZenidContries["Me"] = 26] = "Me";
    ZenidContries[ZenidContries["Ee"] = 27] = "Ee";
    ZenidContries[ZenidContries["Ie"] = 28] = "Ie";
    ZenidContries[ZenidContries["Cy"] = 29] = "Cy";
    ZenidContries[ZenidContries["Lt"] = 31] = "Lt";
    ZenidContries[ZenidContries["Lv"] = 32] = "Lv";
    ZenidContries[ZenidContries["Lu"] = 33] = "Lu";
    ZenidContries[ZenidContries["Mt"] = 34] = "Mt";
    ZenidContries[ZenidContries["Md"] = 35] = "Md";
    ZenidContries[ZenidContries["No"] = 37] = "No";
    ZenidContries[ZenidContries["Pt"] = 38] = "Pt";
    ZenidContries[ZenidContries["Gr"] = 39] = "Gr";
    ZenidContries[ZenidContries["Mk"] = 41] = "Mk";
    ZenidContries[ZenidContries["Rs"] = 42] = "Rs";
    ZenidContries[ZenidContries["Ch"] = 43] = "Ch";
    ZenidContries[ZenidContries["Tr"] = 44] = "Tr";
    ZenidContries[ZenidContries["Vn"] = 46] = "Vn";
    ZenidContries[ZenidContries["In"] = 47] = "In";
})(ZenidContries || (ZenidContries = {}));
const zenidContriesFull = [
    {
        codeNumber: ZenidContries.Cz,
        codeString: ZenidContries[ZenidContries.Cz],
        displayName: 'Czechia'
    },
    {
        codeNumber: ZenidContries.Sk,
        codeString: ZenidContries[ZenidContries.Sk],
        displayName: 'Slovakia'
    },
    {
        codeNumber: ZenidContries.At,
        codeString: ZenidContries[ZenidContries.At],
        displayName: 'Austria'
    },
    {
        codeNumber: ZenidContries.Hu,
        codeString: ZenidContries[ZenidContries.Hu],
        displayName: 'Hungary'
    },
    {
        codeNumber: ZenidContries.Pl,
        codeString: ZenidContries[ZenidContries.Pl],
        displayName: 'Poland'
    },
    {
        codeNumber: ZenidContries.De,
        codeString: ZenidContries[ZenidContries.De],
        displayName: 'Germany'
    },
    {
        codeNumber: ZenidContries.Hr,
        codeString: ZenidContries[ZenidContries.Hr],
        displayName: 'Croatia'
    },
    {
        codeNumber: ZenidContries.Ro,
        codeString: ZenidContries[ZenidContries.Ro],
        displayName: 'Romania'
    },
    {
        codeNumber: ZenidContries.Ru,
        codeString: ZenidContries[ZenidContries.Ru],
        displayName: 'Russian Federation'
    },
    {
        codeNumber: ZenidContries.Ua,
        codeString: ZenidContries[ZenidContries.Ua],
        displayName: 'Ukraine'
    },
    {
        codeNumber: ZenidContries.It,
        codeString: ZenidContries[ZenidContries.It],
        displayName: 'Italy'
    },
    {
        codeNumber: ZenidContries.Dk,
        codeString: ZenidContries[ZenidContries.Dk],
        displayName: 'Denmark'
    },
    {
        codeNumber: ZenidContries.Es,
        codeString: ZenidContries[ZenidContries.Es],
        displayName: 'Spain'
    },
    {
        codeNumber: ZenidContries.Fi,
        codeString: ZenidContries[ZenidContries.Fi],
        displayName: 'Finland'
    },
    {
        codeNumber: ZenidContries.Fr,
        codeString: ZenidContries[ZenidContries.Fr],
        displayName: 'France'
    },
    {
        codeNumber: ZenidContries.Gb,
        codeString: ZenidContries[ZenidContries.Gb],
        displayName: 'Great Britain'
    },
    {
        codeNumber: ZenidContries.Is,
        codeString: ZenidContries[ZenidContries.Is],
        displayName: 'Iceland'
    },
    {
        codeNumber: ZenidContries.Nl,
        codeString: ZenidContries[ZenidContries.Nl],
        displayName: 'Netherlands'
    },
    {
        codeNumber: ZenidContries.Se,
        codeString: ZenidContries[ZenidContries.Se],
        displayName: 'Sweden'
    },
    {
        codeNumber: ZenidContries.Si,
        codeString: ZenidContries[ZenidContries.Si],
        displayName: 'Slovenia'
    },
    {
        codeNumber: ZenidContries.Bg,
        codeString: ZenidContries[ZenidContries.Bg],
        displayName: 'Bulgaria'
    },
    {
        codeNumber: ZenidContries.Be,
        codeString: ZenidContries[ZenidContries.Be],
        displayName: 'Belgium'
    },
    {
        codeNumber: ZenidContries.Ee,
        codeString: ZenidContries[ZenidContries.Ee],
        displayName: 'Estonia'
    },
    {
        codeNumber: ZenidContries.Ie,
        codeString: ZenidContries[ZenidContries.Ie],
        displayName: 'Ireland'
    },
    {
        codeNumber: ZenidContries.Cy,
        codeString: ZenidContries[ZenidContries.Cy],
        displayName: 'Cyprus'
    },
    {
        codeNumber: ZenidContries.Lt,
        codeString: ZenidContries[ZenidContries.Lt],
        displayName: 'Lithuania'
    },
    {
        codeNumber: ZenidContries.Lv,
        codeString: ZenidContries[ZenidContries.Lv],
        displayName: 'Latvia'
    },
    {
        codeNumber: ZenidContries.Lu,
        codeString: ZenidContries[ZenidContries.Lu],
        displayName: 'Luxembourg'
    },
    {
        codeNumber: ZenidContries.Mt,
        codeString: ZenidContries[ZenidContries.Mt],
        displayName: 'Malta'
    },
    {
        codeNumber: ZenidContries.Pt,
        codeString: ZenidContries[ZenidContries.Pt],
        displayName: 'Portugal'
    },
    {
        codeNumber: ZenidContries.Gr,
        codeString: ZenidContries[ZenidContries.Gr],
        displayName: 'Greece'
    }
];
var ZenidPageCodes;
(function (ZenidPageCodes) {
    ZenidPageCodes[ZenidPageCodes["F"] = 0] = "F";
    ZenidPageCodes[ZenidPageCodes["B"] = 1] = "B";
})(ZenidPageCodes || (ZenidPageCodes = {}));
var ZenidSupportedLanguages;
(function (ZenidSupportedLanguages) {
    ZenidSupportedLanguages[ZenidSupportedLanguages["English"] = 0] = "English";
    ZenidSupportedLanguages[ZenidSupportedLanguages["Czech"] = 1] = "Czech";
    ZenidSupportedLanguages[ZenidSupportedLanguages["Polish"] = 2] = "Polish";
    ZenidSupportedLanguages[ZenidSupportedLanguages["German"] = 3] = "German";
})(ZenidSupportedLanguages || (ZenidSupportedLanguages = {}));
var ZenidDocumentRoles;
(function (ZenidDocumentRoles) {
    ZenidDocumentRoles[ZenidDocumentRoles["Idc"] = 0] = "Idc";
    ZenidDocumentRoles[ZenidDocumentRoles["Pas"] = 1] = "Pas";
    ZenidDocumentRoles[ZenidDocumentRoles["Drv"] = 2] = "Drv";
    ZenidDocumentRoles[ZenidDocumentRoles["Res"] = 3] = "Res";
    ZenidDocumentRoles[ZenidDocumentRoles["Gun"] = 4] = "Gun";
    ZenidDocumentRoles[ZenidDocumentRoles["Hic"] = 5] = "Hic";
    ZenidDocumentRoles[ZenidDocumentRoles["Std"] = 6] = "Std";
    ZenidDocumentRoles[ZenidDocumentRoles["Car"] = 7] = "Car";
    ZenidDocumentRoles[ZenidDocumentRoles["Birth"] = 8] = "Birth";
    ZenidDocumentRoles[ZenidDocumentRoles["Add"] = 9] = "Add";
    ZenidDocumentRoles[ZenidDocumentRoles["Ide"] = 10] = "Ide";
    ZenidDocumentRoles[ZenidDocumentRoles["Vis"] = 11] = "Vis"; // F
})(ZenidDocumentRoles || (ZenidDocumentRoles = {}));
var ZenidFeedback;
(function (ZenidFeedback) {
    ZenidFeedback[ZenidFeedback["NoMatchFound"] = 0] = "NoMatchFound";
    ZenidFeedback[ZenidFeedback["AlignCard"] = 1] = "AlignCard";
    ZenidFeedback[ZenidFeedback["HoldSteady"] = 2] = "HoldSteady";
    ZenidFeedback[ZenidFeedback["Blurry"] = 3] = "Blurry";
    ZenidFeedback[ZenidFeedback["ReflectionPresent"] = 4] = "ReflectionPresent";
    ZenidFeedback[ZenidFeedback["Ok"] = 5] = "Ok";
    ZenidFeedback[ZenidFeedback["Dark"] = 6] = "Dark";
    ZenidFeedback[ZenidFeedback["NoFaceFound"] = 7] = "NoFaceFound";
    ZenidFeedback[ZenidFeedback["MoveElsewhere"] = 8] = "MoveElsewhere";
    ZenidFeedback[ZenidFeedback["TiltLeftAndRight"] = 9] = "TiltLeftAndRight";
    ZenidFeedback[ZenidFeedback["TiltUpAndDown"] = 10] = "TiltUpAndDown";
    ZenidFeedback[ZenidFeedback["RotateClockwise"] = 11] = "RotateClockwise";
    ZenidFeedback[ZenidFeedback["RotateCounterClockwise"] = 12] = "RotateCounterClockwise";
    ZenidFeedback[ZenidFeedback["LookAtMe"] = 13] = "LookAtMe";
    ZenidFeedback[ZenidFeedback["TurnHead"] = 14] = "TurnHead";
    ZenidFeedback[ZenidFeedback["Smile"] = 15] = "Smile";
    ZenidFeedback[ZenidFeedback["ConfirmingFace"] = 16] = "ConfirmingFace";
    ZenidFeedback[ZenidFeedback["HoldStill"] = 17] = "HoldStill";
    ZenidFeedback[ZenidFeedback["BadFaceAngle"] = 18] = "BadFaceAngle";
    ZenidFeedback[ZenidFeedback["Center"] = 9] = "Center";
    ZenidFeedback[ZenidFeedback["Barcode"] = 20] = "Barcode";
})(ZenidFeedback || (ZenidFeedback = {}));
var ZenidSdkEvents;
(function (ZenidSdkEvents) {
    ZenidSdkEvents["Loaded"] = "zenid-loaded";
    ZenidSdkEvents["Snapshot"] = "zenid-snapshot";
    ZenidSdkEvents["Feedback"] = "zenid-feedback";
    ZenidSdkEvents["VideoChunk"] = "zenid-video-chunk";
    ZenidSdkEvents["Countdown"] = "zenid-countdown";
    ZenidSdkEvents["RotatedWhileRecording"] = "zenid-rotate-while-recording";
})(ZenidSdkEvents || (ZenidSdkEvents = {}));
const zenidModels = [
    {
        fileName: 'usurf_idc2_f.bin',
        documentCode: ZenidDocumentCodes.IDC2,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_idc2_b.bin',
        documentCode: ZenidDocumentCodes.IDC2,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_drv_f.bin',
        documentCode: ZenidDocumentCodes.DRV,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_idc1_f.bin',
        documentCode: ZenidDocumentCodes.IDC1,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_idc1_b.bin',
        documentCode: ZenidDocumentCodes.IDC1,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_pas_f.bin',
        documentCode: ZenidDocumentCodes.PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_sk_idc_2008plus_b.bin',
        documentCode: ZenidDocumentCodes.SK_IDC_2008plus,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_sk_idc_2008plus_f.bin',
        documentCode: ZenidDocumentCodes.SK_IDC_2008plus,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_sk_drv_2004_08_09_f.bin',
        documentCode: ZenidDocumentCodes.SK_DRV_2004_08_09,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_sk_drv_2013_f.bin',
        documentCode: ZenidDocumentCodes.SK_DRV_2013,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_sk_drv_2015_f.bin',
        documentCode: ZenidDocumentCodes.SK_DRV_2015,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_sk_pas_2008_14_f.bin',
        documentCode: ZenidDocumentCodes.SK_PAS_2008_14,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Sk
    },
    {
        fileName: 'usurf_cz_res_2020_f.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2020,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2020_b.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2020,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2011_14_f.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2011_14,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2011_14_b.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2011_14,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2006_t_f.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2006_T,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2006_t_b.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2006_T,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2006_07_f.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2006_07,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_res_2006_07_b.bin',
        documentCode: ZenidDocumentCodes.CZ_RES_2006_07,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Res,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_gun_2014_f.bin',
        documentCode: ZenidDocumentCodes.CZ_GUN_2014,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Gun,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_cz_gun_2017_f.bin',
        documentCode: ZenidDocumentCodes.CZ_GUN_2017,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Gun,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_at_idc_2002_05_10_f.bin',
        documentCode: ZenidDocumentCodes.AT_IDC_2002_05_10,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_at_idc_2002_05_10_b.bin',
        documentCode: ZenidDocumentCodes.AT_IDC_2002_05_10,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_at_pas_2006_14_f.bin',
        documentCode: ZenidDocumentCodes.AT_PAS_2006_14,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_at_drv_2006_f.bin',
        documentCode: ZenidDocumentCodes.AT_DRV_2006,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_at_drv_2013_f.bin',
        documentCode: ZenidDocumentCodes.AT_DRV_2013,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_pl_idc_2015_f.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2015,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_idc_2015_b.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2015,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_idc_2019_f.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2019,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_idc_2019_b.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2019,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_idc_2001_02_13_f.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2001_02_13,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_idc_2001_02_13_b.bin',
        documentCode: ZenidDocumentCodes.PL_IDC_2001_02_13,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_drv_2013_f.bin',
        documentCode: ZenidDocumentCodes.PL_DRV_2013,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_pl_pas_f.bin',
        documentCode: ZenidDocumentCodes.PL_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_de_idc_2010_f.bin',
        documentCode: ZenidDocumentCodes.DE_IDC_2010,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.De
    },
    {
        fileName: 'usurf_de_idc_2010_b.bin',
        documentCode: ZenidDocumentCodes.DE_IDC_2010,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.De
    },
    {
        fileName: 'usurf_hr_idc_2013_15_f.bin',
        documentCode: ZenidDocumentCodes.HR_IDC_2013_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_hr_idc_2013_15_b.bin',
        documentCode: ZenidDocumentCodes.HR_IDC_2013_15,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_hr_idc_2021_b.bin',
        documentCode: ZenidDocumentCodes.HR_IDC_2021,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_hr_idc_2021_f.bin',
        documentCode: ZenidDocumentCodes.HR_IDC_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_hu_pas_2006_12_f.bin',
        documentCode: ZenidDocumentCodes.HU_PAS_2006_12,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_idc_2016_f.bin',
        documentCode: ZenidDocumentCodes.HU_IDC_2016,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_idc_2016_b.bin',
        documentCode: ZenidDocumentCodes.HU_IDC_2016,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_idc_2000_01_12_f.bin',
        documentCode: ZenidDocumentCodes.HU_IDC_2000_01_12,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_idc_2000_01_12_b.bin',
        documentCode: ZenidDocumentCodes.HU_IDC_2000_01_12,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_add_2012_f.bin',
        documentCode: ZenidDocumentCodes.HU_ADD_2012,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Add,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_drv_2012_13_f.bin',
        documentCode: ZenidDocumentCodes.HU_DRV_2012_13,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_drv_2012_13_b.bin',
        documentCode: ZenidDocumentCodes.HU_DRV_2012_13,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_hu_drv_2012_b_b.bin',
        documentCode: ZenidDocumentCodes.HU_DRV_2012_B,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Hu
    },
    {
        fileName: 'usurf_eu_ehic_2004_a_f.bin',
        documentCode: ZenidDocumentCodes.EU_EHIC_2004_A,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Hic,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_eu_ehic_2004_b_f.bin',
        documentCode: ZenidDocumentCodes.EU_EHIC_2004_B,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Hic,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_it_pas_2006_10_f.bin',
        documentCode: ZenidDocumentCodes.IT_PAS_2006_10,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_it_idc_2016_f.bin',
        documentCode: ZenidDocumentCodes.IT_IDC_2016,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_it_idc_2016_b.bin',
        documentCode: ZenidDocumentCodes.IT_IDC_2016,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_pl_drv_1999_f.bin',
        documentCode: ZenidDocumentCodes.PL_DRV_1999,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_at_idc_2021_f.bin',
        documentCode: ZenidDocumentCodes.AT_IDC_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_at_idc_2021_b.bin',
        documentCode: ZenidDocumentCodes.AT_IDC_2021,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.At
    },
    {
        fileName: 'usurf_ua_idc_2017_f.bin',
        documentCode: ZenidDocumentCodes.UA_IDC_2017,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_ua_idc_2017_b.bin',
        documentCode: ZenidDocumentCodes.UA_IDC_2017,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_ua_pas_2007_15_f.bin',
        documentCode: ZenidDocumentCodes.UA_PAS_2007_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_eu_vis_2019_f.bin',
        documentCode: ZenidDocumentCodes.EU_VIS_2019,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Vis,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_bg_pas_2010_f.bin',
        documentCode: ZenidDocumentCodes.BG_PAS_2010,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Bg
    },
    {
        fileName: 'usurf_bg_idc_2010_f.bin',
        documentCode: ZenidDocumentCodes.BG_IDC_2010,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Bg
    },
    {
        fileName: 'usurf_bg_idc_2010_b.bin',
        documentCode: ZenidDocumentCodes.BG_IDC_2010,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Bg
    },
    {
        fileName: 'usurf_ua_drv_2016_f.bin',
        documentCode: ZenidDocumentCodes.UA_DRV_2016,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_ua_drv_2005_f.bin',
        documentCode: ZenidDocumentCodes.UA_DRV_2005,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_ua_drv_2021_f.bin',
        documentCode: ZenidDocumentCodes.UA_DRV_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Ua
    },
    {
        fileName: 'usurf_be_idc_2013_15_b.bin',
        documentCode: ZenidDocumentCodes.BE_IDC_2013_15,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Be
    },
    {
        fileName: 'usurf_be_idc_2013_15_f.bin',
        documentCode: ZenidDocumentCodes.BE_IDC_2013_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Be
    },
    {
        fileName: 'usurf_be_idc_2020_21_b.bin',
        documentCode: ZenidDocumentCodes.BE_IDC_2020_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Be
    },
    {
        fileName: 'usurf_be_idc_2020_21_f.bin',
        documentCode: ZenidDocumentCodes.BE_IDC_2020_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Be
    },
    {
        fileName: 'usurf_be_pas_2014_17_19_f.bin',
        documentCode: ZenidDocumentCodes.BE_PAS_2014_17_19,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Be
    },
    {
        fileName: 'usurf_cy_idc_2000_08_b.bin',
        documentCode: ZenidDocumentCodes.CY_IDC_2000_08,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cy
    },
    {
        fileName: 'usurf_cy_idc_2000_08_f.bin',
        documentCode: ZenidDocumentCodes.CY_IDC_2000_08,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cy
    },
    {
        fileName: 'usurf_cy_idc_2015_20_b.bin',
        documentCode: ZenidDocumentCodes.CY_IDC_2015_20,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cy
    },
    {
        fileName: 'usurf_cy_idc_2015_20_f.bin',
        documentCode: ZenidDocumentCodes.CY_IDC_2015_20,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Cy
    },
    {
        fileName: 'usurf_cy_pas_2010_20_f.bin',
        documentCode: ZenidDocumentCodes.CY_PAS_2010_20,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Cy
    },
    {
        fileName: 'usurf_de_pas_2007_f.bin',
        documentCode: ZenidDocumentCodes.DE_PAS_2007,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.De
    },
    {
        fileName: 'usurf_de_pas_f.bin',
        documentCode: ZenidDocumentCodes.DE_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.De
    },
    {
        fileName: 'usurf_dk_pas_f.bin',
        documentCode: ZenidDocumentCodes.DK_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Dk
    },
    {
        fileName: 'usurf_ee_idc_2011_b.bin',
        documentCode: ZenidDocumentCodes.EE_IDC_2011,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_ee_idc_2011_f.bin',
        documentCode: ZenidDocumentCodes.EE_IDC_2011,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_ee_idc_2018_21_b.bin',
        documentCode: ZenidDocumentCodes.EE_IDC_2018_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_ee_idc_2018_21_f.bin',
        documentCode: ZenidDocumentCodes.EE_IDC_2018_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_ee_pas_2014_f.bin',
        documentCode: ZenidDocumentCodes.EE_PAS_2014,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_ee_pas_2021_f.bin',
        documentCode: ZenidDocumentCodes.EE_PAS_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ee
    },
    {
        fileName: 'usurf_es_idc_2006_b.bin',
        documentCode: ZenidDocumentCodes.ES_IDC_2006,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_es_idc_2006_f.bin',
        documentCode: ZenidDocumentCodes.ES_IDC_2006,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_es_idc_2015_b.bin',
        documentCode: ZenidDocumentCodes.ES_IDC_2015,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_es_idc_2015_f.bin',
        documentCode: ZenidDocumentCodes.ES_IDC_2015,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_es_pas_2003_06_f.bin',
        documentCode: ZenidDocumentCodes.ES_PAS_2003_06,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_es_pas_f.bin',
        documentCode: ZenidDocumentCodes.ES_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Es
    },
    {
        fileName: 'usurf_fi_idc_2017_21_b.bin',
        documentCode: ZenidDocumentCodes.FI_IDC_2017_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fi
    },
    {
        fileName: 'usurf_fi_idc_2017_21_f.bin',
        documentCode: ZenidDocumentCodes.FI_IDC_2017_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fi
    },
    {
        fileName: 'usurf_fi_pas_f.bin',
        documentCode: ZenidDocumentCodes.FI_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Fi
    },
    {
        fileName: 'usurf_fr_idc_1988_94_b.bin',
        documentCode: ZenidDocumentCodes.FR_IDC_1988_94,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fr
    },
    {
        fileName: 'usurf_fr_idc_1988_94_f.bin',
        documentCode: ZenidDocumentCodes.FR_IDC_1988_94,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fr
    },
    {
        fileName: 'usurf_fr_idc_2021_b.bin',
        documentCode: ZenidDocumentCodes.FR_IDC_2021,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fr
    },
    {
        fileName: 'usurf_fr_idc_2021_f.bin',
        documentCode: ZenidDocumentCodes.FR_IDC_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Fr
    },
    {
        fileName: 'usurf_fr_pas_f.bin',
        documentCode: ZenidDocumentCodes.FR_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Fr
    },
    {
        fileName: 'usurf_gr_pas_2020_f.bin',
        documentCode: ZenidDocumentCodes.GR_PAS_2020,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Gr
    },
    {
        fileName: 'usurf_ie_pas_2006_13_f.bin',
        documentCode: ZenidDocumentCodes.IE_PAS_2006_13,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ie
    },
    {
        fileName: 'usurf_it_idc_2004_b.bin',
        documentCode: ZenidDocumentCodes.IT_IDC_2004,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_it_idc_2004_f.bin',
        documentCode: ZenidDocumentCodes.IT_IDC_2004,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.It
    },
    {
        fileName: 'usurf_lt_idc_2009_12_b.bin',
        documentCode: ZenidDocumentCodes.LT_IDC_2009_12,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lt
    },
    {
        fileName: 'usurf_lt_idc_2009_12_f.bin',
        documentCode: ZenidDocumentCodes.LT_IDC_2009_12,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lt
    },
    {
        fileName: 'usurf_lt_pas_2008_09_11_19_f.bin',
        documentCode: ZenidDocumentCodes.LT_PAS_2008_09_11_19,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Lt
    },
    {
        fileName: 'usurf_lu_idc_2008_13_f.bin',
        documentCode: ZenidDocumentCodes.LU_IDC_2008_13,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lu
    },
    {
        fileName: 'usurf_lu_idc_2014_21_b.bin',
        documentCode: ZenidDocumentCodes.LU_IDC_2014_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lu
    },
    {
        fileName: 'usurf_lu_idc_2014_21_f.bin',
        documentCode: ZenidDocumentCodes.LU_IDC_2014_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lu
    },
    {
        fileName: 'usurf_lu_pas_2015_f.bin',
        documentCode: ZenidDocumentCodes.LU_PAS_2015,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Lu
    },
    {
        fileName: 'usurf_lv_idc_2012_b.bin',
        documentCode: ZenidDocumentCodes.LV_IDC_2012,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_lv_idc_2012_f.bin',
        documentCode: ZenidDocumentCodes.LV_IDC_2012,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_lv_idc_2019_b.bin',
        documentCode: ZenidDocumentCodes.LV_IDC_2019,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_lv_idc_2019_f.bin',
        documentCode: ZenidDocumentCodes.LV_IDC_2019,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_lv_pas_2007_f.bin',
        documentCode: ZenidDocumentCodes.LV_PAS_2007,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_lv_pas_2015_f.bin',
        documentCode: ZenidDocumentCodes.LV_PAS_2015,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Lv
    },
    {
        fileName: 'usurf_mt_idc_2014_b.bin',
        documentCode: ZenidDocumentCodes.MT_IDC_2014,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Mt
    },
    {
        fileName: 'usurf_mt_idc_2014_f.bin',
        documentCode: ZenidDocumentCodes.MT_IDC_2014,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Mt
    },
    {
        fileName: 'usurf_mt_pas_2008_f.bin',
        documentCode: ZenidDocumentCodes.MT_PAS_2008,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Mt
    },
    {
        fileName: 'usurf_nl_idc_2014_17_21_b.bin',
        documentCode: ZenidDocumentCodes.NL_IDC_2014_17_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Nl
    },
    {
        fileName: 'usurf_nl_idc_2014_17_21_f.bin',
        documentCode: ZenidDocumentCodes.NL_IDC_2014_17_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Nl
    },
    {
        fileName: 'usurf_nl_pas_f.bin',
        documentCode: ZenidDocumentCodes.NL_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Nl
    },
    {
        fileName: 'usurf_pt_idc_2007_08_09_15_b.bin',
        documentCode: ZenidDocumentCodes.PT_IDC_2007_08_09_15,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pt
    },
    {
        fileName: 'usurf_pt_idc_2007_08_09_15_f.bin',
        documentCode: ZenidDocumentCodes.PT_IDC_2007_08_09_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Pt
    },
    {
        fileName: 'usurf_pt_pas_2006_09_f.bin',
        documentCode: ZenidDocumentCodes.PT_PAS_2006_09,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Pt
    },
    {
        fileName: 'usurf_ro_idc_2001_06_09_17_21_f.bin',
        documentCode: ZenidDocumentCodes.RO_IDC_2001_06_09_17_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Ro
    },
    {
        fileName: 'usurf_ro_pas_f.bin',
        documentCode: ZenidDocumentCodes.RO_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ro
    },
    {
        fileName: 'usurf_se_idc_2012_21_b.bin',
        documentCode: ZenidDocumentCodes.SE_IDC_2012_21,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Se
    },
    {
        fileName: 'usurf_se_idc_2012_21_f.bin',
        documentCode: ZenidDocumentCodes.SE_IDC_2012_21,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Se
    },
    {
        fileName: 'usurf_se_pas_f.bin',
        documentCode: ZenidDocumentCodes.SE_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Se
    },
    {
        fileName: 'usurf_si_idc_b.bin',
        documentCode: ZenidDocumentCodes.SI_IDC,
        pageCode: ZenidPageCodes.B,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Si
    },
    {
        fileName: 'usurf_si_idc_f.bin',
        documentCode: ZenidDocumentCodes.SI_IDC,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Si
    },
    {
        fileName: 'usurf_si_pas_f.bin',
        documentCode: ZenidDocumentCodes.SI_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Si
    },
    {
        fileName: 'usurf_eu_ehic_2004_c_f.bin',
        documentCode: ZenidDocumentCodes.EU_EHIC_2004_C,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Hic,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_vn_pas_2005_f.bin',
        documentCode: ZenidDocumentCodes.VN_PAS_2005,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Vn
    },
    {
        fileName: 'usurf_cz_birth_f.bin',
        documentCode: ZenidDocumentCodes.CZ_BIRTH,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Birth,
        country: ZenidContries.Cz
    },
    {
        fileName: 'usurf_hr_idc_2003_f.bin',
        documentCode: ZenidDocumentCodes.HR_IDC_2003,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Idc,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_nl_drv_2014_f.bin',
        documentCode: ZenidDocumentCodes.NL_DRV_2014,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Nl
    },
    {
        fileName: 'usurf_nl_drv_2013_f.bin',
        documentCode: ZenidDocumentCodes.NL_DRV_2013,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Drv,
        country: ZenidContries.Nl
    },
    {
        fileName: 'usurf_ch_pas_2010_f.bin',
        documentCode: ZenidDocumentCodes.CH_PAS_2010,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ch
    },
    {
        fileName: 'usurf_gb_pas_f.bin',
        documentCode: ZenidDocumentCodes.GB_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Gb
    },
    {
        fileName: 'usurf_gb_pas_2010_11_15_19_f.bin',
        documentCode: ZenidDocumentCodes.GB_PAS_2010_11_15_19,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Gb
    },
    {
        fileName: 'usurf_rs_pas_2008_f.bin',
        documentCode: ZenidDocumentCodes.RS_PAS_2008,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Rs
    },
    {
        fileName: 'usurf_ba_pas_2014_f.bin',
        documentCode: ZenidDocumentCodes.BA_PAS_2014,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Ba
    },
    {
        fileName: 'usurf_al_pas_2009_f.bin',
        documentCode: ZenidDocumentCodes.AL_PAS_2009,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Al
    },
    {
        fileName: 'usurf_mk_pas_2007_f.bin',
        documentCode: ZenidDocumentCodes.MK_PAS_2007,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Mk
    },
    {
        fileName: 'usurf_by_pas_2021_f.bin',
        documentCode: ZenidDocumentCodes.BY_PAS_2021,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.By
    },
    {
        fileName: 'usurf_by_pas_2006_f.bin',
        documentCode: ZenidDocumentCodes.BY_PAS_2006,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.By
    },
    {
        fileName: 'usurf_me_pas_2008_f.bin',
        documentCode: ZenidDocumentCodes.ME_PAS_2008,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Me
    },
    {
        fileName: 'usurf_no_pas_2020_f.bin',
        documentCode: ZenidDocumentCodes.NO_PAS_2020,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.No
    },
    {
        fileName: 'usurf_no_pas_2011_15_f.bin',
        documentCode: ZenidDocumentCodes.NO_PAS_2011_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.No
    },
    {
        fileName: 'usurf_pl_pas_2011_f.bin',
        documentCode: ZenidDocumentCodes.PL_PAS_2011,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Pl
    },
    {
        fileName: 'usurf_hr_pas_2009_15_f.bin',
        documentCode: ZenidDocumentCodes.HR_PAS_2009_15,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Hr
    },
    {
        fileName: 'usurf_md_pas_2011_14_18_f.bin',
        documentCode: ZenidDocumentCodes.MD_PAS_2011_14_18,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Md
    },
    {
        fileName: 'usurf_is_pas_f.bin',
        documentCode: ZenidDocumentCodes.IS_PAS,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Is
    },
    {
        fileName: 'usurf_is_pas_2006_f.bin',
        documentCode: ZenidDocumentCodes.IS_PAS_2006,
        pageCode: ZenidPageCodes.F,
        documentRole: ZenidDocumentRoles.Pas,
        country: ZenidContries.Is
    }
];


/***/ })

},
/******/ __webpack_require__ => { // webpackRuntimeModules
/******/ var __webpack_exec__ = (moduleId) => (__webpack_require__(__webpack_require__.s = moduleId))
/******/ __webpack_require__.O(0, ["vendor"], () => (__webpack_exec__(1887)));
/******/ var __webpack_exports__ = __webpack_require__.O();
/******/ }
]);
//# sourceMappingURL=main.js.map