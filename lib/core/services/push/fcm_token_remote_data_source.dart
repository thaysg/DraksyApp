/*
-- SQL for fcm_tokens (user_devices) table
create table public.user_devices (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users(id) on delete cascade,
  fcm_token    text not null,
  platform     text not null check (platform in ('android','ios')),
  app_version  text,
  last_seen_at timestamptz default now(),
  created_at   timestamptz default now(),
  unique(user_id, fcm_token)
);

-- RLS
alter table public.user_devices enable row level security;
create policy "devices: user manages own"
  on public.user_devices for all using (auth.uid() = user_id);

create index idx_user_devices_user_id on public.user_devices(user_id);
create index idx_user_devices_last_seen on public.user_devices(last_seen_at);
*/

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_token_remote_data_source.g.dart';

@riverpod
FcmTokenRemoteDataSource fcmTokenRemoteDataSource(Ref ref) =>
    FcmTokenRemoteDataSourceImpl();

abstract class FcmTokenRemoteDataSource {
  Future<void> upsertToken(String userId, String token);
  Future<void> deleteToken(String userId, String token);
}

class FcmTokenRemoteDataSourceImpl implements FcmTokenRemoteDataSource {
  @override
  Future<void> upsertToken(String userId, String token) async {
    // Mock: Do nothing in portfolio
  }

  @override
  Future<void> deleteToken(String userId, String token) async {
    // Mock: Do nothing in portfolio
  }
}
