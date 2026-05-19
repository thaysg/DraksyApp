// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Draksy';

  @override
  String get backToSignIn => 'Voltar para Entrar';

  @override
  String confirmationSentTo(String email) {
    return 'Confirmação enviada para $email';
  }

  @override
  String get clickConfirmationLink =>
      'Clique no link de confirmação no e-mail para completar seu cadastro';

  @override
  String get checkYourEmail => 'Verifique seu e-mail';

  @override
  String get feedTitle => 'Feed';

  @override
  String get feedSubtitle => 'Veja o desempenho da comunidade';

  @override
  String get you => 'Você';

  @override
  String get weeklyChallenge => 'Desafio Semanal';

  @override
  String get weeklyChallengeDesc =>
      'Complete 30 lições essa semana e ganhe uma recompensa!';

  @override
  String get weeklyRanking => 'Ranking semanal';

  @override
  String activityCompletedLesson(String name) {
    return '$name completou uma lição';
  }

  @override
  String activityReachedLevel(String name) {
    return '$name alcançou um novo nível';
  }

  @override
  String activityMaintainedStreak(String name) {
    return '$name manteve o streak';
  }

  @override
  String activityWonAchievement(String name) {
    return '$name ganhou uma conquista';
  }

  @override
  String nowLevel(int level) {
    return 'Agora é nível $level!';
  }

  @override
  String daysStreak(int count) {
    return '$count dias de sequência!';
  }

  @override
  String timeAgo(String time) {
    return 'Há $time';
  }

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueButton => 'Continuar';

  @override
  String get close => 'Fechar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loading => 'Carregando...';

  @override
  String get error => 'Erro';

  @override
  String get success => 'Sucesso';

  @override
  String get settings => 'Configurações';

  @override
  String get welcome => 'Bem-vindo ao Draksy';

  @override
  String welcomeUser(String name) {
    return 'Bem-vindo, $name!';
  }

  @override
  String get signIn => 'Entrar';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get logout => 'Sair';

  @override
  String get signInWithGoogle => 'Entrar com Google';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get worldMap => 'Mapa de Mundos';

  @override
  String get lessons => 'Lições';

  @override
  String get battle => 'Batalha';

  @override
  String get levels => 'Níveis';

  @override
  String level(int number) {
    return 'Nível $number';
  }

  @override
  String get xp => 'XP';

  @override
  String xpProgress(int current, int max) {
    return '$current / $max XP';
  }

  @override
  String get lives => 'Vidas';

  @override
  String livesRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vidas',
      one: '1 vida',
      zero: 'Sem vidas',
    );
    return '$_temp0';
  }

  @override
  String get streak => 'Sequência';

  @override
  String streakDays(int count) {
    return 'Sequência de $count dias';
  }

  @override
  String get coins => 'Moedas';

  @override
  String world(int number) {
    return 'Mundo $number';
  }

  @override
  String lesson(int number) {
    return 'Lição $number';
  }

  @override
  String get locked => 'Bloqueado';

  @override
  String get unlocked => 'Desbloqueado';

  @override
  String get completed => 'Concluído';

  @override
  String get boss => 'Chefe';

  @override
  String get defeat => 'Derrotar';

  @override
  String get exercise => 'Exercício';

  @override
  String get question => 'Pergunta';

  @override
  String get answer => 'Resposta';

  @override
  String get submit => 'Enviar';

  @override
  String get correct => 'Correto!';

  @override
  String get incorrect => 'Incorreto';

  @override
  String get profile => 'Perfil';

  @override
  String get stats => 'Estatísticas';

  @override
  String get totalXp => 'XP Total';

  @override
  String get achievements => 'Conquistas';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Gratuito';

  @override
  String get buyPremium => 'Atualizar para Premium';

  @override
  String get livesPackPrice => 'R\$ 4,90';

  @override
  String get noInternetConnection => 'Sem conexão com a internet';

  @override
  String get noLivesTitle => 'Fim de Jogo';

  @override
  String get noLivesMessage =>
      'Você perdeu todas as suas vidas. Tente novamente mais tarde!';

  @override
  String get lessonCompletedTitle => 'Parabéns!';

  @override
  String get lessonFailedTitle => 'Não foi dessa vez!';

  @override
  String get lessonCompletedMessage =>
      'Você mandou bem e desbloqueou a próxima lição!';

  @override
  String get lessonFailedMessage =>
      'Revise a lição e tente novamente para alcançar 80% de acertos.';

  @override
  String get somethingWentWrong => 'Algo deu errado';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get introTitle1 => 'Draksy';

  @override
  String get introSubtitle1 => 'Domine idiomas com seu\namigo IA';

  @override
  String get introTitle2 => 'Aprenda idiomas de forma divertida\ne gamificada';

  @override
  String get introSubtitle2 =>
      'Exercícios interativos, missões diárias,\ne seu amigo IA pessoal tornam a\nfluência uma brincadeira.';

  @override
  String get introTitle3 => 'Acompanhe progresso, sequências,\ne recompensas';

  @override
  String get introSubtitle3 =>
      'Crie hábitos diários, desbloqueie emblemas\nexclusivos e veja suas habilidades\nevoluírem a cada dia.';

  @override
  String get introTitle4 => 'Pratique diariamente e\nmelhore rápido';

  @override
  String get introSubtitle4 =>
      'Dedique apenas 10 minutos por dia.\nPrática consistente é a chave para\ndominar qualquer idioma.';

  @override
  String get introGetStarted => 'Começar Agora';

  @override
  String get next => 'Próximo';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta? ';

  @override
  String get dontHaveAccount => 'Não tem uma conta? ';

  @override
  String get logIn => 'Entrar';

  @override
  String get welcomeBack => 'Bem-vindo de volta!';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get signInToContinue => 'Por favor, entre para continuar';

  @override
  String get joinUsToStart => 'Junte-se a nós para começar sua jornada hoje';

  @override
  String get yourName => 'Seu nome';

  @override
  String get yourEmail => 'Seu e-mail';

  @override
  String get yourPassword => 'Sua senha';

  @override
  String get createPassword => 'Crie uma senha';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get orContinueWith => 'OU CONTINUE COM';

  @override
  String get orSignUpWith => 'OU CADASTRE-SE COM';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String byCreatingAccount(String tos, String privacy) {
    return 'Ao criar uma conta, você concorda com nossos $tos e $privacy.';
  }

  @override
  String get fullName => 'Nome Completo';

  @override
  String get signInWithApple => 'Entrar com Apple';

  @override
  String get skip => 'Pular';

  @override
  String get goodMorning => 'BOM DIA';

  @override
  String get goodAfternoon => 'BOA TARDE';

  @override
  String get goodEvening => 'BOA NOITE';

  @override
  String get dailyChallenge => 'Desafio Diário';

  @override
  String get continueLearning => 'Continuar Aprendendo';

  @override
  String get newGrammar => 'Nova Gramática';

  @override
  String get startChallenge => 'Começar Desafio';

  @override
  String get resume => 'Retomar';

  @override
  String get seeAll => 'Ver tudo';

  @override
  String get home => 'Início';

  @override
  String get shop => 'Loja';

  @override
  String unitLesson(int unit, int lesson) {
    return 'Unidade $unit • Lição $lesson';
  }

  @override
  String get livesFull => 'Cheia';

  @override
  String get masterPastTense => 'Domine o\nPassado';

  @override
  String get progress => 'Progresso';

  @override
  String lessonsCount(int count) {
    return '$count Lições';
  }

  @override
  String get premiumMembership => 'Assinatura Premium';

  @override
  String get annualPlan => 'Plano Anual';

  @override
  String get monthlyPlan => 'Plano Mensal';

  @override
  String get bestValue => 'MELHOR PREÇO';

  @override
  String get perYear => '/ano';

  @override
  String get perMonth => '/mês';

  @override
  String get unlimitedHearts => 'Corações Ilimitados';

  @override
  String get noAds => 'Sem Anúncios';

  @override
  String get offlineAccess => 'Acesso Offline';

  @override
  String get monthlyStreakRepair => 'Reparo de Sequência Mensal';

  @override
  String get startFreeTrial => 'Iniciar Teste Grátis de 14 Dias';

  @override
  String get subscribeMonthly => 'Assinar Mensalmente';

  @override
  String get powerUps => 'Power-ups';

  @override
  String get refillHearts => 'Recarregar Corações';

  @override
  String get getBackInTheGame => 'Volte para o jogo';

  @override
  String get streakFreeze => 'Bloqueio de Sequência';

  @override
  String get protectYourStreak => 'Proteja sua sequência por 1 dia';

  @override
  String get purchase => 'Comprar';

  @override
  String get buy => 'Comprar';

  @override
  String refillHeartsAmount(int amount) {
    return '$amount Corações';
  }

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get learningStats => 'Estatísticas de Aprendizado';

  @override
  String get accuracy => 'Precisão';

  @override
  String get badges => 'Conquistas';

  @override
  String get manageBadges => 'Gerenciar Conquistas';

  @override
  String get draksyPremium => 'Draksy Premium';

  @override
  String get manageSubscription => 'Gerenciar assinatura';

  @override
  String get inviteFriends => 'Convidar Amigos';

  @override
  String get inviteFriendsReward => 'Ganhe 1 semana de Premium grátis!';

  @override
  String get helpSupport => 'Ajuda e Suporte';

  @override
  String get faqContact => 'FAQ e contato';

  @override
  String get notifications => 'Notificações';

  @override
  String get mockUserName => 'Alex Dragonheart';

  @override
  String get mockUserTag => '@alex_learns';

  @override
  String get english => 'Inglês';

  @override
  String get spanish => 'Espanhol';

  @override
  String get intermediate => 'Intermediário';

  @override
  String get beginner => 'Iniciante';

  @override
  String get champion => 'Campeão';

  @override
  String get top10 => 'Top 10%';

  @override
  String get onFire => 'Pegando Fogo';

  @override
  String get thirtyDayStreak => 'Sequência de 30 dias';

  @override
  String get master => 'Mestre';

  @override
  String get account => 'Conta';

  @override
  String get changePassword => 'Alterar sua senha';

  @override
  String get learningGoals => 'Aprendizado e Metas';

  @override
  String get dailyGoal => 'Meta Diária';

  @override
  String xpPerDay(int xp) {
    return '$xp XP por dia';
  }

  @override
  String get practiceReminders => 'Lembretes de Prática';

  @override
  String dailyAt(String time) {
    return 'Diariamente às $time';
  }

  @override
  String get difficulty => 'Dificuldade';

  @override
  String get audio => 'Áudio';

  @override
  String get soundEffects => 'Efeitos Sonoros';

  @override
  String get voiceSpeed => 'Velocidade da Voz';

  @override
  String get normal => 'Normal';

  @override
  String get deleteAccount => 'Excluir Conta';

  @override
  String get deleteAccountTitle => 'Excluir Conta?';

  @override
  String get deleteAccountMessage =>
      'Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita e você perderá todo o seu progresso.';

  @override
  String get delete => 'Excluir';

  @override
  String get general => 'Geral';

  @override
  String get preferences => 'Preferências';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get sound => 'Som';

  @override
  String get haptics => 'Vibração';

  @override
  String get termsPrivacy => 'Termos e Privacidade';

  @override
  String get advanced => 'Avançado';

  @override
  String get allCategories => 'Todas as Categorias';

  @override
  String get grammar => 'Gramática';

  @override
  String get vocabulary => 'Vocabulário';

  @override
  String get beginnerDesc => 'Básico, saudações e frases simples.';

  @override
  String get intermediateDesc => 'Gramática complexa e conversas diárias.';

  @override
  String get advancedDesc => 'Fala fluente e vocabulário profissional.';

  @override
  String timePerLesson(int minutes) {
    return '~$minutes min/lição';
  }

  @override
  String get categoryProgress => 'Progresso da Categoria';

  @override
  String unitsCount(int current, int total) {
    return '$current/$total Lições';
  }

  @override
  String unitNumber(int number) {
    return 'Lição $number';
  }

  @override
  String nextUnit(int number) {
    return 'PRÓXIMO: LIÇÃO $number';
  }

  @override
  String sectionCleared(int number) {
    return 'Seção $number Concluída!';
  }

  @override
  String bonusXpEarned(int xp) {
    return 'Você ganhou $xp XP de bônus';
  }

  @override
  String get greetingsAndIntros => 'SAUDAÇÕES\nE APRESENTAÇÕES';

  @override
  String holaMeansHello(String hello, String language) {
    return '\"Hola\" significa $hello em $language.';
  }

  @override
  String get grammarTip => 'Dica de Gramática';

  @override
  String get grammarTipDesc =>
      'Use a qualquer hora do dia!\nÉ casual e amigável.';

  @override
  String get howDoYouSayHello => 'Como se diz \"Olá\"?';

  @override
  String get categories => 'Categorias';

  @override
  String get featured => 'Destaques';

  @override
  String get specials => 'Especiais';

  @override
  String get profileUpdatedSuccess => 'Perfil atualizado com sucesso';

  @override
  String get displayName => 'Nome de Exibição';

  @override
  String get enterDisplayName => 'Digite seu nome de exibição';

  @override
  String get username => 'Nome de Usuário';

  @override
  String get enterUsername => 'Digite seu nome de usuário';

  @override
  String get enterEmail => 'Digite seu e-mail';

  @override
  String get aboutYou => 'Sobre Você';

  @override
  String get enterBio => 'Conte-nos sobre você';

  @override
  String get saveChanges => 'Salvar Alterações';

  @override
  String get adjustPhoto => 'Ajustar Foto';

  @override
  String get finish => 'Concluir';

  @override
  String get reset => 'Resetar';

  @override
  String get camera => 'Câmera';

  @override
  String get cameraDescription => 'Tirar uma nova foto';

  @override
  String get gallery => 'Galeria';

  @override
  String get galleryDescription => 'Escolha uma foto da sua galeria';

  @override
  String get profilePhoto => 'Foto de Perfil';

  @override
  String get profileUpdateError => 'Erro ao atualizar Perfil';

  @override
  String get errorNoInternet =>
      'Sem conexão com a internet. Verifique sua rede.';

  @override
  String get errorNetworkTimeout => 'A requisição expirou. Tente novamente.';

  @override
  String get errorConnectionRefused => 'Conexão recusada pelo servidor.';

  @override
  String get errorSsl => 'Falha na conexão segura. Erro de certificado SSL.';

  @override
  String get errorNetwork => 'Ocorreu um erro de rede. Tente novamente.';

  @override
  String get errorInvalidCredentials => 'E-mail ou senha incorretos.';

  @override
  String get errorTokenExpired =>
      'Sua sessão expirou. Por favor, entre novamente.';

  @override
  String get errorTokenInvalid => 'Token de autenticação inválido.';

  @override
  String get errorSessionExpired =>
      'Sessão expirada. Por favor, entre novamente.';

  @override
  String get errorEmailNotConfirmed =>
      'Por favor, confirme seu e-mail antes de entrar.';

  @override
  String get errorPhoneNotConfirmed =>
      'Por favor, confirme seu telefone antes de entrar.';

  @override
  String get errorUserNotFound => 'Usuário não encontrado.';

  @override
  String get errorUserAlreadyExists => 'Já existe uma conta com este e-mail.';

  @override
  String get errorWeakPassword =>
      'A senha é muito fraca. Use pelo menos 8 caracteres, incluindo letras e números.';

  @override
  String get errorUnauthorized =>
      'Você não tem autorização para realizar esta ação.';

  @override
  String get errorAccountDisabled =>
      'Esta conta foi desativada. Entre em contato com o suporte.';

  @override
  String get errorRateLimit =>
      'Muitas tentativas. Por favor, aguarde um momento e tente novamente.';

  @override
  String get errorMfaRequired => 'Autenticação de dois fatores é necessária.';

  @override
  String get errorInvalidMfaCode =>
      'Código de verificação inválido ou expirado.';

  @override
  String get errorPasswordResetExpired =>
      'O link de redefinição de senha expirou. Solicite um novo.';

  @override
  String get errorAuth => 'Ocorreu um erro de autenticação.';

  @override
  String get errorOAuthNotEnabled =>
      'Este provedor de login social não está habilitado nas configurações do servidor.';

  @override
  String get errorDuplicateKey => 'Já existe um registro com este valor.';

  @override
  String get errorForeignKeyViolation =>
      'A operação falhou devido a uma dependência de registro relacionado.';

  @override
  String get errorTransaction =>
      'A transação no banco de dados falhou e foi revertida.';

  @override
  String get errorEmptyResult => 'Nenhum registro encontrado para a consulta.';

  @override
  String get errorTableNotFound =>
      'A tabela do banco de dados solicitada não foi encontrada.';

  @override
  String get errorDatabase => 'Ocorreu um erro no banco de dados.';

  @override
  String get errorInternalServer =>
      'Erro interno do servidor. Tente novamente mais tarde.';

  @override
  String get errorServiceUnavailable =>
      'O serviço está temporariamente indisponível. Tente novamente mais tarde.';

  @override
  String get errorBadGateway =>
      'Bad gateway. O servidor recebeu uma resposta inválida.';

  @override
  String get errorGatewayTimeout =>
      'Gateway timeout. O servidor demorou muito para responder.';

  @override
  String get errorApiEndpointNotFound =>
      'O endpoint da API solicitado não foi encontrado.';

  @override
  String get errorForbidden =>
      'Você não tem permissão para acessar este recurso.';

  @override
  String get errorServer =>
      'Ocorreu um erro no servidor. Tente novamente mais tarde.';

  @override
  String get errorCache => 'Ocorreu um erro no armazenamento local.';

  @override
  String get errorUpload => 'Falha no envio do arquivo. Tente novamente.';

  @override
  String get errorDownload => 'Falha no download do arquivo. Tente novamente.';

  @override
  String get errorFileTooLarge =>
      'O arquivo excede o tamanho máximo permitido.';

  @override
  String get errorInvalidFileType => 'Tipo de arquivo não permitido.';

  @override
  String get errorFileAlreadyExists => 'Já existe um arquivo com este nome.';

  @override
  String get errorStorage => 'Ocorreu um erro no armazenamento de arquivos.';

  @override
  String get errorRequiredField => 'Este campo é obrigatório.';

  @override
  String get errorMismatch => 'Os valores não coincidem.';

  @override
  String get errorValidation => 'A validação falhou.';

  @override
  String get errorPermissionDenied =>
      'Permissão negada. Conceda acesso nas configurações do seu dispositivo.';

  @override
  String get errorPermissionPermanentlyDenied =>
      'Permissão negada permanentemente. Ative-a nas configurações do seu dispositivo.';

  @override
  String get errorTechnical =>
      'Ocorreu um erro técnico. Entre em contato com o suporte.';

  @override
  String get errorUnknown => 'Ocorreu um erro inesperado.';

  @override
  String get inviteFriendsLabel => 'Convidar\namigos';

  @override
  String get inviteFriendsMessage =>
      'Oi! Estou usando o Draksy para aprender idiomas. Junte-se a mim e vamos praticar juntos!';

  @override
  String get inviteFriendsURL => 'https://draksy.app';

  @override
  String xpValue(String xp) {
    return '$xp XP';
  }

  @override
  String get progressHistory => 'Histórico de Progresso';

  @override
  String get viewAllCompletedLessons => 'Ver todas as lições concluídas';
}
