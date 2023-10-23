library screen;

import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/provider/auth_provider.dart';
import 'package:sims_ppob/provider/balance_provider.dart';
import 'package:sims_ppob/provider/banner_provider.dart';
import 'package:sims_ppob/provider/layanan_provider.dart';
import 'package:sims_ppob/provider/transaksi_provider.dart';
import 'package:sims_ppob/utilities/utilities.dart';
import 'package:sims_ppob/widgets/widgets.dart';

part 'splash/splash_screen.dart';
part 'autentikasi/login_screen.dart';
part 'autentikasi/register_screen.dart';
part 'home/home_screen.dart';
part 'navigation/navigation_screen.dart';
part 'top_up/top_up_screen.dart';
part 'transaksi/transaksi_screen.dart';
part 'profile/profile_screen.dart';
part 'profile/edit_profile_screen.dart';
part 'pembayaran/pembayaran_screen.dart';
