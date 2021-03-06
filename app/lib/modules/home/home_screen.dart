import 'package:app/core/book/book_bloc.dart';
import 'package:app/core/book/book_query.dart';
import 'package:app/core/day/day_bloc.dart';
import 'package:app/core/services/app_navigator_service.dart';
import 'package:app/modules/home/bloc/home_bloc.dart';
import 'package:app/modules/home/bloc/home_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'elements/book_item/book_item.dart';
import 'elements/statistics/read_books_stats_charts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: BlocProvider(
          create: (_) => HomeBloc(
            bookQuery: context.read<BookQuery>(),
            bookBloc: context.read<BookBloc>(),
            dayBloc: context.read<DayBloc>(),
            appNavigatorService: context.read<AppNavigatorService>(),
          ),
          child: Column(
            children: [
              _ReadBooks(),
              ReadBooksStatsCharts(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadBooks extends StatelessWidget {
  const _ReadBooks();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeQuery>(
      builder: (context, query) {
        return StreamBuilder(
          stream: query.booksIds$,
          builder: (_, AsyncSnapshot<List<String>> snapshot) {
            List<String>? booksIds = snapshot.data;
            if (booksIds != null) {
              return Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Aktualnie czytane książki',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  ...booksIds.map((id) => BookItem(bookId: id)),
                ],
              );
            }
            return SizedBox(height: 0);
          },
        );
      },
    );
  }
}
