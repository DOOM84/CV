-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 09, 2019 at 09:37 PM
-- Server version: 5.7.27-0ubuntu0.18.04.1
-- PHP Version: 7.2.21-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `portfolio`
--

-- --------------------------------------------------------

--
-- Table structure for table `avatars`
--

CREATE TABLE `avatars` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `avatars`
--

INSERT INTO `avatars` (`id`, `user_id`, `img`, `created_at`, `updated_at`) VALUES
(1, 1, 'ava_11565090110.jpeg', '2018-06-12 07:02:56', '2019-08-06 11:15:10'),
(2, 3, 'ava_31549021462.png', '2019-01-31 10:14:14', '2019-02-01 09:44:22');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `en_name`, `ua_name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PHP', 'PHP', 'PHP', 'php', 1, '2018-06-07 07:45:36', '2019-02-10 11:09:43'),
(2, 'Laravel', 'Laravel', 'Laravel', 'laravel', 1, '2018-06-07 07:45:47', '2018-07-20 09:52:04'),
(3, 'Переводы', 'Translations', 'Переклади', 'perevody', 1, '2018-06-07 07:46:00', '2019-08-08 15:41:27');

-- --------------------------------------------------------

--
-- Table structure for table `category_post`
--

CREATE TABLE `category_post` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_post`
--

INSERT INTO `category_post` (`id`, `category_id`, `post_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(5, 1, 3, NULL, NULL),
(6, 2, 3, NULL, NULL),
(10, 3, 3, NULL, NULL),
(13, 2, 4, NULL, NULL),
(15, 3, 4, NULL, NULL),
(17, 1, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `parent_id`, `body`, `created_at`, `updated_at`) VALUES
(2, 1, 4, NULL, 'Welcome to this site', '2019-01-25 11:29:56', '2019-01-25 11:29:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_06_01_095234_create_menus_table', 1),
(4, '2018_06_01_102100_add_status_and_ordered_to_menus', 2),
(5, '2018_06_03_101001_create_skills_table', 3),
(6, '2018_06_03_102802_add_status_to_skills', 4),
(7, '2018_06_03_111518_create_works_table', 5),
(8, '2018_06_04_085614_create_trainings_table', 6),
(9, '2018_06_05_101859_create_projects_table', 7),
(10, '2018_06_05_102351_create_project_skill_table', 8),
(11, '2018_06_05_110832_add_image_to_projects', 9),
(12, '2018_06_05_113750_add_thumb_to_projects', 10),
(13, '2018_06_07_102015_create_categories_table', 11),
(14, '2018_06_07_102737_add_status_to_categories', 12),
(15, '2018_06_07_105828_create_posts_table', 13),
(16, '2018_06_07_143642_create_category_post_table', 14),
(17, '2018_06_11_091419_add_is_admin_and_status_to_users', 15),
(18, '2018_06_12_090638_create_comments_table', 16),
(19, '2018_06_12_091319_create_avatars_table', 17),
(20, '2018_06_14_113511_create_rates_table', 18),
(21, '2018_07_18_130458_make_users_email_limit', 19),
(22, '2018_07_20_114948_add_menus_en_versions', 20),
(23, '2018_07_20_115251_add_categories_en_versions', 21),
(24, '2018_07_20_115456_add_posts_en_versions', 22),
(25, '2018_07_20_115854_add_projects_en_versions', 23),
(26, '2018_07_20_120143_add_skills_en_versions', 24),
(27, '2018_07_20_120357_add_trainings_en_versions', 25),
(28, '2018_07_20_120628_add_works_en_versions', 26);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_subtitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_body` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) DEFAULT NULL,
  `posted_by` int(11) DEFAULT NULL,
  `source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `en_title`, `subtitle`, `en_subtitle`, `slug`, `body`, `en_body`, `status`, `posted_by`, `source`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Простой способ преобразовать HTML таблицу в PHP массив', 'An easy way to convert an HTML table into a PHP array', 'Преобразование данных HTML таблицы с удаленного веб-сайта в PHP массив', 'Convert HTML table data from a remote web site to a PHP array', 'prostoy-sposob-preobrazovat-html-tablitsu-v-php-massiv', '<p>Вступление</p>\n<p>Представим, что вам нужно прочесть данные из таблицы, расположенной на стороннем сайте и не просто прочитать, а поместить их в вашу базу данных. С помощью PHP возможно решить эту задачу, поместив данные таблицы в массив PHP.</p>\n<p>В этой статье будет показан простой пример как это сделать на языке PHP.</p>\n<p>Перед тем как начать, взгляните на содержимое этого изображения.</p>\n<p style=\"text-align: center;\"><img style=\"width: 351px;\" src=\"../../images/blog/post_add1565088585.png\" alt=\"\" /></p>\n<p>Как сказано выше, это пример таблицы, которая будет сконвертирована в PHP массив.</p>\n<p>Итак, начнем. Нам необходимо загрузить содержимое таблицы на веб-странице. Создадим переменную, скажем, $htmlContent, в которую положим результат работы функции file_get_contents() с адресом нашей веб-страницы. Затем создадим экземпляр класса DOMDocument, которое даст нам доступ к DOM содержимому удаленной веб-страницы. Загрузим нашу $htmlContent для получения данных.</p>\n<p>Мы хотим получить только элемент таблицы, поэтому нам нужен только элемент заголовка таблицы (тег &lt;th&gt;) и деталей таблицы (тег &lt;td&gt;). В этом контексте мы сохраняем значения в переменные $Header и $Detail соответственно.</p>\n<pre class=\"language-php\"><code>\n$htmlContent = file_get_contents\n(\"http://teskusman.esy.es/index.html\");\n		\n$DOM = new DOMDocument();\n$DOM-&gt;loadHTML($htmlContent);\n	\n$Header = $DOM-&gt;getElementsByTagName(\'th\');\n$Detail = $DOM-&gt;getElementsByTagName(\'td\');\n</code></pre>\n<p>На следующем шаге мы хотим получить имя заголовка HTML таблицы , это легко; для этого нам нужно воспользоваться циклом foreach (), чтобы получить заголовок таблицы и сохранить его в массиве, который будет содержать текстовые данные с помощью свойства textContent. Исходный код теперь выглядит следующим образом:</p>\n<pre class=\"language-php\"><code>\n$htmlContent = file_get_contents\n(\"http://teskusman.esy.es/index.html\");\n		\n$DOM = new DOMDocument();\n$DOM-&gt;loadHTML($htmlContent);\n	\n$Header = $DOM-&gt;getElementsByTagName(\'th\');\n$Detail = $DOM-&gt;getElementsByTagName(\'td\');\n\n//#Получаем заголовки полей таблицы\nforeach($Header as $NodeHeader) \n{\n$aDataTableHeaderHTML[] = trim($NodeHeader-&gt;textContent);\n}\nprint_r($aDataTableHeaderHTML); die();\n</code></pre>\n<p>Теперь в массиве мы имеем текстовые данные заголовков полей таблицы:</p>\n<p style=\"text-align: center;\"><img style=\"width: 421px;\" src=\"../../images/blog/post_add1565088621.png\" alt=\"\" /></p>\n<p>Это только начало, у нас уже есть заголовки полей таблицы. Теперь мы хотим получить содержимое HTML-таблицы. Вот код:</p>\n<pre class=\"language-php\"><code>\n$htmlContent = file_get_contents\n(\"http://teskusman.esy.es/index.html\");\n		\n$DOM = new DOMDocument();\n$DOM-&gt;loadHTML($htmlContent);\n	\n$Header = $DOM-&gt;getElementsByTagName(\'th\');\n$Detail = $DOM-&gt;getElementsByTagName(\'td\');\n\n//#Получаем заголовки полей таблицы\nforeach($Header as $NodeHeader) \n{\n$aDataTableHeaderHTML[] = trim($NodeHeader-&gt;textContent);\n}\n//print_r($aDataTableHeaderHTML); die();\n\n//#Получаем данные строк таблицы без имени заголовка в качестве ключа\n$i = 0;\n$j = 0;\nforeach($Detail as $sNodeDetail) \n{\n$aDataTableDetailHTML[$j][] = trim($sNodeDetail-&gt;textContent);\n$i = $i + 1;\n$j = $i % count($aDataTableHeaderHTML) == 0 ? $j + 1 : $j;\n}\nprint_r($aDataTableDetailHTML); die();\n</code></pre>\n<p>В результате работы кода мы увидим следующий массив данных таблицы:</p>\n<p style=\"text-align: center;\"><img style=\"width: 423px;\" src=\"../../images/blog/post_add1565088659.png\" alt=\"\" /></p>\n<p>Хорошо, все в порядке, но мы хотим сопоставить массив PHP с ключом, который является именем заголовка столбца таблицы вместо того, чтобы показывать массив только с его номером индекса для каждого элемента. Чтобы сопоставить данные HTML -таблицы с нашим массивом PHP, мы используем этот полный код:</p>\n<pre class=\"language-php\"><code>\n$htmlContent = file_get_contents\n(\"http://teskusman.esy.es/index.html\");\n		\n$DOM = new DOMDocument();\n$DOM-&gt;loadHTML($htmlContent);\n	\n$Header = $DOM-&gt;getElementsByTagName(\'th\');\n$Detail = $DOM-&gt;getElementsByTagName(\'td\');\n\n//#Получаем заголовки полей таблицы\nforeach($Header as $NodeHeader) \n{\n$aDataTableHeaderHTML[] = trim($NodeHeader-&gt;textContent);\n}\n//print_r($aDataTableHeaderHTML); die();\n\n//#Получаем данные строк таблицы без имени заголовка в качестве ключа\n$i = 0;\n$j = 0;\nforeach($Detail as $sNodeDetail) \n{\n$aDataTableDetailHTML[$j][] = trim($sNodeDetail-&gt;textContent);\n$i = $i + 1;\n$j = $i % count($aDataTableHeaderHTML) == 0 ? $j + 1 : $j;\n}\n//print_r($aDataTableDetailHTML); die();\n	\n//#Получаем данные строк таблицы в качестве содержимого массива и названием заголовка полей в качестве ключа (используя ранее созданный нами массив $aDataTableHeaderHTML).\nfor($i = 0; $i &lt; count($aDataTableDetailHTML); $i++)\n{\nfor($j = 0; $j &lt; count($aDataTableHeaderHTML); $j++)\n{\n$aTempData[$i][$aDataTableHeaderHTML[$j]] = $aDataTableDetailHTML[$i][$j];\n}\n}\n$aDataTableDetailHTML = $aTempData; unset($aTempData);\nprint_r($aDataTableDetailHTML); die();\n</code></pre>\n<p>В результате работы кода мы увидим следующий массив данных таблицы:</p>\n<p style=\"text-align: center;\"><img style=\"width: 422px;\" src=\"../../images/blog/post_add1565088709.png\" alt=\"\" /></p>\n<p>Теперь вы можете изменить URL-адрес в функции file_get_contents () на другие URL-адреса, содержащие HTML-таблицу. Это всего лишь простая пошаговая демонстрация преобразования HTML-таблицы в массив PHP. Мы можем сделать лучший алгоритм, чтобы напрямую сопоставлять ключ и значение массива, а не разделить его на три части (получить имя заголовка, детализировать, а затем отобразить заголовок и данные). При желании, с небольшим усовершенствованием, мы можем использовать этот массив PHP для вставки в базу данных.</p>\n<p>Функция getElementsByTagName() здесь очень полезна. С помощью этой DOM-функции мы также можем воспроизводить все HTML-содержимое на веб-страницах, а не только с помощью HTML-таблицы . Возможно, мы хотим найти ссылку внутри веб-страницы, перейдя по ссылке, чтобы найти другую ссылку, или, может быть, она будет веб-роботом, одной из важных частей поисковой системы, такой как Google, например.</p>', '1', 1, NULL, 'https://www.codeproject.com/Tips/1074174/Simple-Way-to-Convert-HTML-Table-Data-into-PHP-Arr', 'post_1531734733.jpeg', '2018-06-07 10:07:28', '2019-08-07 18:00:55'),
(3, 'Создание \"живого\" поиска в Laravel', 'Creating a live search in Laravel', 'Создание \"живого\" поиска в Laravel, используя AJAX', 'Creating a live search in Laravel using AJAX', 'sozdanie-zhivogo-poiska-v-laravel', '<p>Если у вас есть блог или магазин электронной торговли, панель поиска всегда является важным компонентом пользовательского интерфейса.</p>\n<p>Однако дни простой панели поиска закончились.</p>\n<p>В наши дни панель поиска в реальном времени намного эффективнее, чем простая панель поиска, потому что она отображает аналогичный контент в режиме реального времени.</p>\n<p>Это увеличивает вероятность продажи, поскольку клиент может увидеть самый большой выбор сопутствующих товаров.</p>\n<p>Чтобы продемонстрировать полные возможности панели поиска в реальном времени, я создам таблицу товаров, и панель поиска проведет прямой поиск по названиям товаров и отобразит весь связанный контент.</p>\n<p><strong>Создание миграции</strong></p>\n<pre class=\"language-php\"><code>use Illuminate\\Support\\Facades\\Schema;\n\nuse Illuminate\\Database\\Schema\\Blueprint;\n\nuse Illuminate\\Database\\Migrations\\Migration;\n\n\n\nclass CreateProductsTable extends Migration\n\n{\n\n   /**\n\n    * Run the migrations.\n\n    *\n\n    * @return void\n\n    */\n\n	public function up()\n{\n\nSchema::create(\'products\', \nfunction (Blueprint $table) {\n\n    $table-&gt;;increments(\'id\');\n\n     $table-&gt;;timestamps();\n\n    $table-&gt;string(\'Title\');\n\n    $table-&gt;string(\'Description\');\n\n    $table-&gt;integer(\'price\');\n\n       });\n\n   }\n\n\n\n   /**\n\n    * Reverse the migrations.\n\n    *\n\n    * @return void\n\n    */\n\n	public function down()\n{\nSchema::dropIfExists(\'products\');\n\n   }\n\n}\n</code></pre>\n<p>Теперь, когда миграция создана, выполните следующую команду в терминале:</p>\n<p><strong>php artisan migrate</strong></p>\n<p>Следующим шагом является зполнение базы данных информацией. Перейдите в ваш менеджер управления базой данных и заполните таблицу фиктивными данными.</p>\n<p>После этого таблица должна выглядить примерно так:</p>\n<p style=\"text-align: center;\"><img style=\"width: 100%;\" src=\"../../images/blog/post_add1565088968.png\" alt=\"\" /></p>\n<p><strong>Создание контроллера</strong></p>\n<p>Теперь, когда таблица базы данных готова, следующим шагом является создание контроллера. Введите следующую команду в свой терминал.</p>\n<p><strong>php artisan make:controller SearchController</strong></p>\n<p>Теперь перейдите по пути <strong>app/Http/controller/SearchController.php </strong>в созданный контроллер и вставьте в него следующий код:</p>\n<pre class=\"language-php\"><code>namespace App\\Http\\Controllers;\n\n\nuse Illuminate\\Http\\Request;\n\nuse DB;\n\n\n\n\nclass SearchController extends Controller\n\n{\n\n	public function index()\n{\n\nreturn view(\'search.search\');\n\n}\n\n	public function search (Request $request)\n{\n\nif($request-&gt;ajax())\n\n{\n\n$output=\"\";\n\n$products=DB::table(\'products\')\n-&gt;where(\'title\',\'LIKE\',\'%\'.$request-&gt;search.\"%\")\n-&gt;get();\n\nif($products)\n\n{\n\nforeach ($products as $key =&gt; $product) {\n\n$output.=\'\'.\n \n\'\'.$product-&gt;id.\'\'.\n \n\'\'.$product-&gt;title.\'\'.\n \n\'\'.$product-&gt;description.\'\'.\n \n\'\'.$product-&gt;price.\'\'.\n \n\'\';\n\n}\nreturn Response($output);\n   }\n   }\n}\n}\n</code></pre>\n<p>Файл <strong>script.js</strong></p>\n<pre class=\"language-php\"><code>$(\'#search\').on(\'keyup\',function(){\n\n$value=$(this).val();\n\n$.ajax({\n\ntype : \'get\',\n\nurl : \'{{URL::to(\'search\')}}\',\n\ndata:{\'search\':$value},\n\nsuccess:function(data){\n\n$(\'tbody\').html(data);\n\n}\n\n});\n\n\n\n})\n\n$.ajaxSetup({ headers: { \'csrftoken\' : \'{{ csrf_token() }}\' } });\n</code></pre>\n<p>Теперь давайте углубимся в код и поймем, что здесь происходит. В теге head я создал метатег, который позволит выполнить вызов AJAX на сервере. Затем я подключил Bootstrap, CSS и библиотеку jQuery.</p>\n<p>В теге body я создал простой пользовательский интерфейс для отображения информации о товаре с помощью Bootstrap. И затем я использовал Ajax скрипт. Это важная часть для понимания.</p>\n<p>Сценарий AJAX выберет значение из строки поиска, как только вы его введете. Он отправляет значение в поисковый URL вашего приложения (или маршрут), который будет выполнять второй метод контроллера (search).</p>\n<p>Он выполнит поиск в БД и получит ответ в виде AJAX кода. Как только он будет получен, ответ будет отображаться в формате HTML. Нижняя строка скрипта используется для проверки токена для обеспечения выполнения исполняемого файла сценария AJAX.</p>\n<p><strong>Настройка маршрутов</strong></p>\n<p>Перейдите к маршрутам <strong>routes/web.php</strong> и добавьте в него следующие строки маршрутизации.</p>\n<pre class=\"language-php\"><code>Route::get(\'/\',\'SearchController@index\');\nRoute::get(\'/search\',\'SearchController@search\');\n</code></pre>\n<p><strong>Тестирование панели поиска в реальном времени. </strong></p>\n<p>Теперь, чтобы проверить функциональность, выполните поиск (вы можете начать со следующего примера):</p>\n<p><img style=\"width: 100%;\" src=\"../../images/blog/post_add1565089022.png\" alt=\"\" /></p>\n<p>Как вы можете видеть, по мере того как я ввел W, панель поиска начала возвращать результаты, содержащие частичные совпадения.</p>\n<p><strong>Заключение</strong></p>\n<p>Как вы могли видеть, реализация \"живого\" поиска в Laravel с AJAX - достаточно простая задача.</p>\n<p>Во многих случаях процесс внедрения прост и значительно улучшает UI / UX вашего сайта.</p>', '1', 1, NULL, 'https://www.cloudways.com/blog/live-search-laravel-ajax/', 'post_1531734486.jpeg', '2018-06-08 11:43:35', '2019-08-06 11:08:53'),
(4, 'Полнотекстовый поиск в Laravel 5', 'Full-text search in Laravel 5', 'Реализация полнотекстового поиска в Laravel 5', 'Implementation of full-text search in Laravel 5', 'polnotekstovyy-poisk-v-laravel-5', '<p><strong>Когда использовать полнотекстовый поиск?</strong></p>\n<ul style=\"list-style-type: square;\">\n<li>Для поиска по нескольким столбцам одновременно,&nbsp;то есть, к примеру, сопоставление пользователей с именем, фамилией, электронной почтой пользователя.</li>\n<li>Для сортировки результатов по релевантности,&nbsp;то есть более близкие совпадения должны быть в верхней части.</li>\n<li>Чтобы повысить производительность запросов с помощью `LIKE &lsquo;%term%&rsquo;</li>\n<li>Использовать расширенные шаблоны поиска, например пропускать результаты, содержащие определенное слово.</li>\n<li>Использовать собственный сервер MySQL</li>\n</ul>\n<p>В этом уроке мы будем использовать полнотекстовый поиск, чтобы находить пользователей по&nbsp;именам столбцов:&nbsp;имя, фамилия и адрес электронной почты. Мы разработаем&nbsp;трейт&nbsp;для создания области запроса, которая может использоваться вместе с построителями запросов для точной настройки поиска</p>\n<p><strong><em>1.Добавление индекса при миграции.</em></strong></p>\n<p>FULL TEXT - это тип индекса, и он принимает один или несколько столбцов. Поскольку Laravel не оснащена специальным методом для добавления индекса, нам нужно будет использовать т.н. \"сырой\" запрос.&nbsp;</p>\n<pre class=\"language-php\"><code>\n	public function up()\n{\n    Schema::table(\'users\', function (Blueprint $table) {\n        $table-&gt;increments(\'id\');\n        $table-&gt;string(\'first_name\');\n        $table-&gt;string(\'last_name\');\n        $table-&gt;string(\'email\')-&gt;unique();\n    });\n \n    // Full Text Index\n    DB::statement(\'ALTER TABLE users ADD FULLTEXT fulltext_index (first_name, last_name, email)\');\n}\n</code></pre>\n<p><strong><em>2.Применим миграции.</em></strong></p>\n<p><strong>php artisan migrate</strong></p>\n<p>Помните, что вам нужен MYSQL версии 5.6+ с типом таблиц InnoDB</p>\n<p><em><strong>3.Определение столбцов с возможностью поиска</strong></em></p>\n<p>Перейдите в модель пользователя и добавьте следующий код. Необходимо указать точно такие же столбцы, которые были определены в индексе в&nbsp;шаге 1.</p>\n<pre class=\"language-php\"><code>\n	protected $searchable = [\n        \'first_name\',\n        \'last_name\',\n        \'email\'\n    ];\n</code></pre>\n<p>Если эти столбцы не совпадают со столбцами, определенными при создании индекса, то MySQL не найдет индекс, выдаст следующее сообщение об ошибке:&nbsp;</p>\n<p><strong>SQLSTATE[HY000]: General error: 1191 Can\'t find FULLTEXT index matching the column list.</strong></p>\n<p><em><strong>4.Создание трейта</strong></em></p>\n<p>Вместо того чтобы помещать код поиска в каждую модель, мы будем использовать трейт, чтобы централизовать его&nbsp;и избежать повторения.</p>\n<p>Создайте файл FullTextSearch.php в той же папке, что и ваши модели, и вставьте следующий код.</p>\n<pre class=\"language-php\"><code>\nnamespace App;\n \ntrait FullTextSearch\n{\n/**\n     * Замена пробелов полнотекстовыми подстановочными знаками\n     *\n     * @param string $term\n     * @return string\n     */\nprotected function fullTextWildcards($term) \n{\n        $reservedSymbols = [\'-\', \'+\', \'&lt;\', \'&gt;\', \'@\', \'(\', \')\', \'~\'];\n        $term = str_replace($reservedSymbols, \'\', $term);\n \n        $words = explode(\' \', $term);\n \n        foreach($words as $key =&gt; $word) {\n/** \n     * применяем оператор + только к большим словам,\n     * т.к. слова с меньшим количеством символов не индексируется mysql\n     */\n            if(strlen($word) &gt;= 3) {\n                $words[$key] = \'+\' . $word . \'*\';\n            }\n        }\n \n        $searchTerm = implode( \' \', $words);\n \n        return $searchTerm;\n    }\n \n    /**\n     * Создаем заготовку запроса полнотекстового поиска\n     *\n     * @param \\Illuminate\\Database\\Eloquent\\Builder $query\n     * @param string $term\n     * @return \\Illuminate\\Database\\Eloquent\\Builder\n     */\npublic function scopeSearch($query, $term) \n{\n        $columns = implode(\',\',$this-&gt;searchable);\n \n        $query-&gt;whereRaw(\"MATCH ({$columns}) AGAINST (? IN BOOLEAN MODE)\" , $this-&gt;fullTextWildcards($term));\n \n        return $query;\n    }\n}\n</code></pre>\n<p><u><em>Режим полнотекстового поиска по умолчанию.</em></u></p>\n<p><strong>MATCH (first_name, last_name, email) AGAINST (\'john\') </strong></p>\n<p>Это будет соответствовать любому столбцу, в котором есть слово \'john\'.</p>\n<p><em><u>Булевский режим. </u></em></p>\n<p>Существует несколько режимов поиска, но мы будем использовать булевский режим, который позволяет использовать специальные операторы для точной настройки поиска. В частности, мы будем использовать * в качестве подстановочного знака. Полный список операторов находится в официальной документации.</p>\n<p><strong>MATCH (first_name, last_name, email) AGAINST (\'john*\' IN BOOLEAN MODE) </strong></p>\n<p>Это будет соответствовать любому столбцу, в котором есть слово, начинающееся с &laquo;john&raquo;, например &laquo;johny&raquo;.</p>\n<p><em><strong>5.Подключим трейт</strong></em></p>\n<p>Вернемся к модели пользователя, просто подключив трейт.</p>\n<pre class=\"language-php\"><code>\nclass User extends Authenticatable\n{\n    use FullTextSearch;\n</code></pre>\n<p><em><strong>6.Начало поиска</strong></em></p>\n<p>Использование поиска очень просто. Поскольку мы использовали заготовку запроса, ее можно использовать отдельно или в сочетании с другими where, order by или даже&nbsp;pagination.</p>\n<pre class=\"language-php\"><code>\n// предполагая, что &laquo;arian&raquo; - это столбец first_name и &laquo;acosta&raquo; в last_name\n// все последующие запросы будут работать!\nUser::search(\'arian acosta\')-&gt;get();\nUser::search(\'acosta arian\')-&gt;get();\nUser::search(\'ari aco\')-&gt;get();\nUser::search(\'arian\')-&gt;get();\nUser::search(\'arian acosta somethingelse\')-&gt;get();\n\n// уточним запрос\nUser::search(\'arian\')-&gt;where(\'is_active\', \'=\', 1)-&gt;get();\nUser::search(\'arian\')-&gt;latest()-&gt;get();\nUser::search(\'arian\')-&gt;paginate();\n</code></pre>\n<p><em><strong>7.Использование на нескольких моделях</strong></em></p>\n<p>Что ж, у нас уже есть трейт, все, что вам нужно сделать, чтобы использовать его&nbsp;с любой другой моделью:</p>\n<ol>\n<li>Добавить полнотекстовый&nbsp;индекс</li>\n<li>Применить миграции</li>\n<li>Определить&nbsp;столбцы&nbsp;для поиска</li>\n<li>Подключить трейт полнотекстового поиска</li>\n</ol>\n<p><strong>Вывод</strong></p>\n<p>Надеюсь, эта инструкция была&nbsp;полезна. На мой взгляд, настройка этой функции в Laravel с MySQL очень проста и мощна. Это определенно стоит попробовать, прежде чем перейти к другим более сложным решениям.</p>\n<p><strong>СОВЕТ: СОРТИРОВКА СООТВЕТСТВИЯ</strong></p>\n<p>Для сортировки&nbsp;результатов по релевантности&nbsp;вы можете выбрать автоматически сгенерированную оценку релевантности в качестве столбца в MySQL следующим образом:</p>\n<pre class=\"language-php\"><code>\nSELECT *, \nMATCH(first_name, last_name, email) AGAINST (\'term\' IN BOOLEAN MODE) AS relevance_score\nFROM users\nWHERE MATCH(first_name, last_name, email) AGAINST (\'term\' IN BOOLEAN MODE);\n</code></pre>\n<p>Просто измените метод scopeSearch в трейте FullTextSearch:</p>\n<pre class=\"language-php\"><code>\n/**\n * Составьте запрос, который соответствует полнотекстовому поиску фразы.\n * Эта версия вычисляет и сортирует по оценке релевантности.\n *\n * @param \\Illuminate\\Database\\Eloquent\\Builder $query\n * @param string $term\n * @return \\Illuminate\\Database\\Eloquent\\Builder\n */\npublic function scopeSearch($query, $term)\n{\n    $columns = implode(\',\',$this-&gt;searchable);\n\n    $searchableTerm = $this-&gt;fullTextWildcards($term);\n\n    return $query-&gt;selectRaw(\"MATCH ({$columns}) AGAINST (? IN BOOLEAN MODE) AS relevance_score\", [$searchableTerm])\n        -&gt;whereRaw(\"MATCH ({$columns}) AGAINST (? IN BOOLEAN MODE)\", $searchableTerm)\n        -&gt;orderByDesc(\'relevance_score\');\n}\n</code></pre>', '1', 1, NULL, 'https://arianacosta.com/php/laravel/tutorial-full-text-search-laravel-5/', 'post_1565086859.jpeg', '2018-06-08 11:44:51', '2019-08-06 13:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `en_name`, `ua_name`, `details`, `en_details`, `ua_details`, `image`, `thumb`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Сайт музыкальной группы', 'Musical band site', 'Сайт музичного гурту', 'Сайт музыкальной группы <a style=\"color:blue\" target=\"_blank\" href=\"http://innersilence.net\">Inner Silence</a>', 'The site of the musical band <a style=\"color:blue\" target=\"_blank\" href=\"http://innersilence.net\">Inner Silence</a>', 'Сайт музичного гурту <a style=\"color:blue\" target=\"_blank\" href=\"http://innersilence.net\">Inner Silence</a>', 'proj_1549644336.png', 'projThumb_1528199140.png', 1, '2018-06-05 08:26:43', '2019-02-08 16:45:46'),
(2, 'Цитаты великих философов', 'Quotes of the great philosophers', 'Цитати великих філософів', 'Цитаты великих фиолософов', 'Quotes of the great philosophers', 'Цитати великих філософів', 'proj_1528199303.png', 'projThumb_1528199302.png', 1, '2018-06-05 08:48:22', '2019-02-08 15:32:44'),
(3, 'Новости Европейского футбола', 'Eurofootball news', 'Новини Європейського футболу', 'Новости еврофутбола', 'Eurofootball news', 'Новини Європейського футболу', 'proj_1565183599.png', 'projThumb_1528199438.png', 1, '2018-06-05 08:50:38', '2019-08-07 13:13:19'),
(4, 'Интернет-магазин', 'Online store', 'Інтернет-магазин', 'Интернет-магазин', 'Online store', 'Інтернет-магазин', 'proj_1528199537.png', 'projThumb_1528199537.png', 1, '2018-06-05 08:52:17', '2018-07-20 09:51:24'),
(5, 'Интернет-магазин', 'Online store', 'Інтернет-магазин', 'Другая версия интернет-магазина', 'Another version of the online store', 'Інша версія інтернет-магазину', 'proj_1531901819.png', 'projThumb_1531901819.png', 1, '2018-07-18 08:16:59', '2019-02-08 16:47:54'),
(7, 'Система тестирования', 'Testing system', 'Система тестування', 'Адаптивный сайт системы тестирования по английскому языку <a style=\"color:blue\" target=\"_blank\" href=\"https://test.aim2.top\">test.aim2.top</a>', 'Responsive English Testing Site <a style=\"color:blue\" target=\"_blank\" href=\"https://test.aim2.top\">test.aim2.top</a>', 'Адаптивний веб-сайт системи тестування з англійської мови <a style=\"color:blue\" target=\"_blank\" href=\"https://test.aim2.top\">test.aim2.top</a>', 'proj_1565171503.png', NULL, 1, '2019-08-07 09:51:43', '2019-08-07 09:57:13');

-- --------------------------------------------------------

--
-- Table structure for table `project_skill`
--

CREATE TABLE `project_skill` (
  `id` int(10) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_skill`
--

INSERT INTO `project_skill` (`id`, `project_id`, `skill_id`, `created_at`, `updated_at`) VALUES
(4, 2, 2, NULL, NULL),
(5, 2, 3, NULL, NULL),
(6, 2, 4, NULL, NULL),
(7, 2, 5, NULL, NULL),
(8, 3, 1, NULL, NULL),
(9, 3, 2, NULL, NULL),
(10, 3, 3, NULL, NULL),
(11, 3, 4, NULL, NULL),
(13, 4, 1, NULL, NULL),
(14, 4, 2, NULL, NULL),
(15, 4, 3, NULL, NULL),
(16, 4, 4, NULL, NULL),
(17, 4, 5, NULL, NULL),
(18, 5, 1, NULL, NULL),
(19, 5, 2, NULL, NULL),
(20, 5, 3, NULL, NULL),
(21, 5, 4, NULL, NULL),
(22, 5, 5, NULL, NULL),
(26, 1, 1, NULL, NULL),
(33, 1, 2, NULL, NULL),
(34, 1, 4, NULL, NULL),
(39, 7, 6, NULL, NULL),
(40, 7, 2, NULL, NULL),
(41, 7, 1, NULL, NULL),
(42, 7, 3, NULL, NULL),
(43, 7, 4, NULL, NULL),
(46, 3, 6, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`id`, `user_id`, `post_id`, `rating`, `created_at`, `updated_at`) VALUES
(23, 1, 3, NULL, '2019-07-31 12:37:43', '2019-07-31 12:37:43'),
(24, 1, 4, NULL, '2019-07-31 12:37:51', '2019-07-31 12:37:51'),
(25, 1, 1, NULL, '2019-07-31 12:38:32', '2019-07-31 12:38:32'),
(26, 3, 4, NULL, '2019-08-01 19:15:37', '2019-08-01 19:15:37');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`, `en_name`, `slug`, `rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CSS', 'CSS', 'css', 65, 1, '2018-06-03 07:42:17', '2019-02-06 21:54:23'),
(2, 'PHP', 'PHP', 'php', 85, 1, '2018-06-03 07:42:33', '2019-02-06 09:41:26'),
(3, 'AJAX', 'AJAX', 'ajax', 45, 1, '2018-06-03 07:43:02', '2018-07-20 09:44:29'),
(4, 'JavaScript', 'JavaScript', 'javascript', 60, 1, '2018-06-03 07:43:27', '2019-02-06 10:16:05'),
(5, 'Jquery', 'Jquery', 'jquery', 45, 1, '2018-06-03 07:44:25', '2019-02-06 13:13:27'),
(6, 'Vue.js', 'Vue.js', 'vuejs', 40, 1, '2019-01-21 11:37:09', '2019-08-07 12:55:16');

-- --------------------------------------------------------

--
-- Table structure for table `trainings`
--

CREATE TABLE `trainings` (
  `id` int(10) UNSIGNED NOT NULL,
  `univer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `en_univer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ua_univer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `en_faculty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ua_faculty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `en_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ua_details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'black',
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trainings`
--

INSERT INTO `trainings` (`id`, `univer`, `en_univer`, `ua_univer`, `faculty`, `en_faculty`, `ua_faculty`, `details`, `en_details`, `ua_details`, `start`, `end`, `image`, `color`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Восточноукраинский национальный университет имени В. Даля', 'Volodymyr Dahl East Ukrainian National University', 'Східноукраїнський національний університет імені В. Даля', 'Финансово-экономический факультет', 'Faculty of Finance and Economics', 'Фінансово-економічний факультет', 'Специальность «Международная экономика», диплом магистра', 'Specialty \"International Economics\" Master\'s degree', 'Спеціальність «Міжнародна економіка», диплом магістра', '2001', '2006', '1528107296.jpeg', 'orange', 1, '2018-06-04 07:14:05', '2019-02-08 09:59:00'),
(2, 'Восточноукраинский национальный университет имени В. Даля', 'Volodymyr Dahl East Ukrainian National University', 'Східноукраїнський національний університет імені В. Даля', 'Финансово-экономический факультет', 'Faculty of Finance and Economics', 'Фінансово-економічний факультет', 'Специальность «Экономическая кибернетика», диплом магистра', 'Specialty \"Economic Cybernetics\" Master\'s Degree', 'Спеціальність «Економічна кібернетика», диплом магістра', '2006', '2011', '1531734041.jpeg', 'pink', 1, '2018-07-16 09:40:41', '2018-08-20 08:29:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `is_admin`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'DOOM', 'd00m7@ukr.net', '$2y$10$6UPbDKQz0w5U3TIOXs1h3OxN80g2Mg5bEW8HHvT8Vx77tRCugW02e', 1, 1, 'sepgKX3xdI0vIvqbVd8xC14QjC88p3jJfCDmLXDdnIQLQYk6iNMgvTsY53yS', '2018-06-11 06:38:12', '2019-07-31 07:48:59'),
(3, 'DOOM84', '_doom_@ukr.net', '$2y$10$6UPbDKQz0w5U3TIOXs1h3OxN80g2Mg5bEW8HHvT8Vx77tRCugW02e', 0, 1, NULL, '2019-01-28 09:56:49', '2019-02-19 13:26:41');

-- --------------------------------------------------------

--
-- Table structure for table `works`
--

CREATE TABLE `works` (
  `id` int(10) UNSIGNED NOT NULL,
  `start` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_start` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_start` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_end` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_end` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `en_seat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua_seat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `en_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ua_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `en_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ua_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'black',
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `works`
--

INSERT INTO `works` (`id`, `start`, `en_start`, `ua_start`, `end`, `en_end`, `ua_end`, `seat`, `en_seat`, `ua_seat`, `company`, `en_company`, `ua_company`, `description`, `en_description`, `ua_description`, `color`, `status`, `created_at`, `updated_at`) VALUES
(1, 'ноябрь 2006 г.', 'November 2006', 'Листопад 2006 р.', 'август 2017 г.', 'August 2017', 'серпень 2017 р.', 'Ассистент, доцент кафедры международной экономики', 'Assistant, Associate Professor of the Department of International Economics', 'Асистент, доцент кафедри міжнародної економіки', 'Восточноукраинский национальный университет имени В. Даля', 'Volodymyr Dahl East Ukrainian National University', 'Східноукраїнський національний університет імені В. Даля', 'В том числе работа с иностранцами (Нигерия) на английском языке (3 года)', 'Including work with foreigners (Nigeria) in english (3 years)', 'У тому числі робота з іноземцями (Нігерія) англійською мовою (3 роки)', 'green', 1, '2018-06-03 08:52:38', '2019-08-07 16:52:22'),
(2, 'август 2017 г.', 'August 2017', 'серпень 2017 р.', 'наст. время', 'present time', 'тепер. час', 'Web-разработчик', 'Web Developer', 'Web-розробник', 'Фриланс', 'Freelance', 'Фріланс', 'Разработка Web-приложений', 'Web applications development', 'Розробка Web-додатків', 'cyan', 1, '2018-06-03 08:56:32', '2018-07-20 09:48:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `avatars`
--
ALTER TABLE `avatars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_post`
--
ALTER TABLE `category_post`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_index` (`user_id`),
  ADD KEY `comments_post_id_index` (`post_id`),
  ADD KEY `comments_parent_id_index` (`parent_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `posts` ADD FULLTEXT KEY `fulltext_index1` (`title`,`subtitle`,`body`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_skill`
--
ALTER TABLE `project_skill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainings`
--
ALTER TABLE `trainings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `avatars`
--
ALTER TABLE `avatars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `category_post`
--
ALTER TABLE `category_post`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `project_skill`
--
ALTER TABLE `project_skill`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `trainings`
--
ALTER TABLE `trainings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `works`
--
ALTER TABLE `works`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
