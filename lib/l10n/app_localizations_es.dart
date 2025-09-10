// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Demostración de AdMob';

  @override
  String get welcomeTitle => 'Bienvenido a la Demo de AdMob';

  @override
  String get welcomeSubtitle =>
      'Explora todos los formatos de anuncios de AdMob de manera creativa';

  @override
  String get bannerAds => 'Anuncios Banner';

  @override
  String get nativeAds => 'Anuncios Nativos';

  @override
  String get rewardedAds => 'Anuncios Recompensados';

  @override
  String get interstitialAds => 'Anuncios Intersticiales';

  @override
  String get allFormatsDemo => 'Demo de Todos los Formatos';

  @override
  String get startDemo => 'Iniciar Demo';

  @override
  String get bannerShowcase => 'Presentación de Banner';

  @override
  String get standardBanner => 'Banner Estándar';

  @override
  String get standardBannerDesc => '320x50 píxeles - Formato más común';

  @override
  String get largeBanner => 'Banner Grande';

  @override
  String get largeBannerDesc => '320x100 píxeles - Mejor visibilidad';

  @override
  String get mediumRectangle => 'Rectángulo Mediano';

  @override
  String get mediumRectangleDesc => '300x250 píxeles - Alto engagement';

  @override
  String get leaderboard => 'Tabla de Posiciones';

  @override
  String get leaderboardDesc => '728x90 píxeles - Optimizado para tablet';

  @override
  String get adaptiveBanner => 'Banner Adaptativo';

  @override
  String get adaptiveBannerDesc =>
      'Responsivo - Se adapta al ancho de pantalla';

  @override
  String get nativeIntegration => 'Integración de Anuncios Nativos';

  @override
  String get feedNativeAd => 'Anuncio Nativo en Feed';

  @override
  String get feedNativeAdDesc =>
      'Integrado perfectamente en el feed de contenido';

  @override
  String get articleNativeAd => 'Anuncio Nativo en Artículo';

  @override
  String get articleNativeAdDesc => 'Parece parte del artículo';

  @override
  String get cardNativeAd => 'Anuncio Nativo en Tarjeta';

  @override
  String get cardNativeAdDesc => 'Estilizado como tarjeta destacada';

  @override
  String get customNativeAd => 'Anuncio Nativo Personalizado';

  @override
  String get customNativeAdDesc => 'Estilo completamente personalizado';

  @override
  String get rewardedExperience => 'Experiencia de Anuncios Recompensados';

  @override
  String get extraLives => 'Vidas Extra';

  @override
  String get extraLivesDesc => 'Mira un anuncio para obtener 3 vidas extra';

  @override
  String get premiumUnlock => 'Desbloqueo Premium';

  @override
  String get premiumUnlockDesc =>
      'Mira un anuncio para desbloquear funciones premium';

  @override
  String get scoreMultiplier => 'Multiplicador de Puntuación';

  @override
  String get scoreMultiplierDesc =>
      'Mira un anuncio para obtener multiplicador 2X';

  @override
  String get interstitialTriggers => 'Disparadores de Intersticial';

  @override
  String get buttonClickTrigger => 'Disparador de Clic en Botón';

  @override
  String get buttonClickTriggerDesc =>
      '33% de probabilidad de mostrar anuncio al hacer clic';

  @override
  String get timeBasedTrigger => 'Disparador Basado en Tiempo';

  @override
  String get timeBasedTriggerDesc => 'Muestra anuncio después de 5 segundos';

  @override
  String get manualTrigger => 'Disparador Manual';

  @override
  String get manualTriggerDesc => 'Forzar mostrar anuncio intersticial';

  @override
  String get smartTriggers => 'Disparadores Inteligentes';

  @override
  String get smartTriggersDesc =>
      'Los anuncios intersticiales se activan inteligentemente basados en el comportamiento del usuario, asegurando una experiencia óptima mientras se maximiza la revenue.';

  @override
  String get completeExperience => 'Experiencia Completa de Anuncios';

  @override
  String get experienceDesc =>
      'Esta sección demuestra cómo todos los formatos de anuncios funcionan juntos en un escenario de aplicación real:';

  @override
  String get interactiveContent => 'Contenido Interactivo';

  @override
  String get unlockContent => 'Desbloquear Contenido con Anuncio';

  @override
  String get triggerAd => 'Activar Anuncio';

  @override
  String get adUnavailable => 'Anuncio no disponible';

  @override
  String get adNotReady =>
      'Anuncio no está listo aún. Por favor intenta de nuevo.';

  @override
  String get rewardedAdNotReady =>
      'Anuncio recompensado no está listo aún. Por favor intenta de nuevo.';

  @override
  String congratulations(String amount, String type) {
    return '¡Felicitaciones! ¡Ganaste $amount $type!';
  }

  @override
  String get premiumContentUnlocked => '¡Contenido premium desbloqueado!';

  @override
  String get multiplierActivated => '¡Multiplicador 2X activado!';

  @override
  String get extraLivesAdded => '¡3 vidas extra añadidas!';

  @override
  String get actionCompleted => '¡Acción completada!';

  @override
  String get keepScrolling => '¡Sigue desplazándote para activar intersticial!';

  @override
  String get adDismissed => 'Anuncio descartado';

  @override
  String get contentUnlocked => '¡Contenido desbloqueado!';

  @override
  String get premiumFeaturesActivated => '¡Funciones premium activadas!';

  @override
  String get adWillShow => 'El anuncio se mostrará en 5 segundos...';

  @override
  String get exitApp => '¿Salir de la App?';

  @override
  String get watchAdBeforeExit =>
      '¿Quieres ver un anuncio rápido antes de irte?';

  @override
  String get stay => 'Quedarse';

  @override
  String get exitWithAd => 'Salir con Anuncio';

  @override
  String get advertisement => 'Publicidad';

  @override
  String get sponsored => 'Patrocinado';

  @override
  String get featured => 'Destacado';

  @override
  String get outOfLives => '¡Sin Vidas!';

  @override
  String get watchAdForLives => '¡Mira un anuncio para obtener 3 vidas extra!';

  @override
  String get getExtraLives => 'Obtener Vidas Extra';

  @override
  String get premiumContent => 'Contenido Premium';

  @override
  String get watchAdForPremium =>
      '¡Mira un anuncio para desbloquear contenido exclusivo!';

  @override
  String get watchAdUnlock => 'Ver Anuncio y Desbloquear';

  @override
  String get bonusMultiplier => '¡Bono Diario 2X!';

  @override
  String get watchAdForMultiplier =>
      '¡Mira un anuncio para duplicar tus recompensas diarias!';

  @override
  String get activateMultiplier => 'Activar Bono 2X';

  @override
  String get lives => 'Vidas';

  @override
  String get score => 'Puntuación';

  @override
  String get premium => 'Premium';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get scrollThreshold => 'Umbral de Desplazamiento';

  @override
  String get scrollThresholdDesc => 'Se muestra después de desplazar 1000px';
}
