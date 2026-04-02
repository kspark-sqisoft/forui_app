import 'package:dio/dio.dart';

/// [DummyJSON](https://dummyjson.com/) Todos 응답 한 줄.
final class DummyTodo {
  const DummyTodo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  final int id;
  final String todo;
  final bool completed;
  final int userId;

  DummyTodo copyWith({bool? completed, String? todo}) {
    return DummyTodo(
      id: id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId,
    );
  }

  factory DummyTodo.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final userId = json['userId'];
    return DummyTodo(
      id: id is int ? id : int.parse('$id'),
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: userId is int ? userId : int.parse('$userId'),
    );
  }
}

/// [dummyJsonTodosQueryProvider]와 GET 쿼리 파라미터에 대응합니다.
final class TodosQuery {
  const TodosQuery({this.limit = 15, this.skip = 0});

  final int limit;
  final int skip;
}

/// 목록 + 페이지 메타 ([GET /todos?limit&skip](https://dummyjson.com/docs/todos/)).
final class TodosPageData {
  const TodosPageData({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<DummyTodo> items;
  final int total;
  final int skip;
  final int limit;

  TodosPageData copyWith({
    List<DummyTodo>? items,
    int? total,
    int? skip,
    int? limit,
  }) {
    return TodosPageData(
      items: items ?? this.items,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}

/// [GET/PUT/POST](https://dummyjson.com/docs/todos/) — 서버는 시뮬레이션이며 응답은 실제 JSON 형태입니다.
final class DummyJsonTodosClient {
  DummyJsonTodosClient(this._dio);

  final Dio _dio;

  Future<TodosPageData> fetchPage({required int limit, required int skip}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/todos',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    final map = res.data!;
    final raw = map['todos'] as List<dynamic>;
    final items = raw
        .map((e) => DummyTodo.fromJson(e as Map<String, dynamic>))
        .toList();
    return TodosPageData(
      items: items,
      total: (map['total'] as num).toInt(),
      skip: int.tryParse('${map['skip']}') ?? skip,
      limit: (map['limit'] as num).toInt(),
    );
  }

  Future<DummyTodo> updateCompleted(int id, bool completed) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/todos/$id',
      data: {'completed': completed},
    );
    return DummyTodo.fromJson(res.data!);
  }

  Future<DummyTodo> addTodo(String todo, {int userId = 1}) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/todos/add',
      data: {'todo': todo, 'completed': false, 'userId': userId},
    );
    return DummyTodo.fromJson(res.data!);
  }
}
