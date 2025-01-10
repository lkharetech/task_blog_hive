class BlogDataModal {
  int? id;
  String? jsonrpc;
  List<Result>? result;

  BlogDataModal({this.id, this.jsonrpc, this.result});

  BlogDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jsonrpc = json['jsonrpc'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jsonrpc'] = this.jsonrpc;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  List<ActiveVotes>? activeVotes;
  String? author;
  String? authorPayoutValue;
  double? authorReputation;
  List<Beneficiaries>? beneficiaries;
  List<Null>? blacklists;
  String? body;
  String? category;
  int? children;
  String? created;
  String? curatorPayoutValue;
  int? depth;
  bool? isPaidout;
  JsonMetadata? jsonMetadata;
  String? maxAcceptedPayout;
  int? netRshares;
  double? payout;
  String? payoutAt;
  String? pendingPayoutValue;
  int? percentHbd;
  String? permlink;
  int? postId;
  String? promoted;
  int? reblogs;
  List<Null>? replies;
  Stats? stats;
  String? title;
  String? updated;
  String? url;
  String? communityTitle;

  Result(
      {this.activeVotes,
        this.author,
        this.authorPayoutValue,
        this.authorReputation,
        this.beneficiaries,
        this.blacklists,
        this.body,
        this.category,
        this.children,
        this.created,
        this.curatorPayoutValue,
        this.depth,
        this.isPaidout,
        this.jsonMetadata,
        this.maxAcceptedPayout,
        this.netRshares,
        this.payout,
        this.payoutAt,
        this.pendingPayoutValue,
        this.percentHbd,
        this.permlink,
        this.postId,
        this.promoted,
        this.reblogs,
        this.replies,
        this.stats,
        this.title,
        this.updated,
        this.url,
        this.communityTitle});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['active_votes'] != null) {
      activeVotes = <ActiveVotes>[];
      json['active_votes'].forEach((v) {
        activeVotes!.add(new ActiveVotes.fromJson(v));
      });
    }
    author = json['author'];
    authorPayoutValue = json['author_payout_value'];
    authorReputation = json['author_reputation'];
    if (json['beneficiaries'] != null) {
      beneficiaries = <Beneficiaries>[];
      json['beneficiaries'].forEach((v) {
        beneficiaries!.add(new Beneficiaries.fromJson(v));
      });
    }
    // if (json['blacklists'] != null) {
    //   blacklists = <Null>[];
    //   json['blacklists'].forEach((v) {
    //     blacklists!.add(new Null.fromJson(v));
    //   });
    // }
    body = json['body'];
    category = json['category'];
    children = json['children'];
    created = json['created'];
    curatorPayoutValue = json['curator_payout_value'];
    depth = json['depth'];
    isPaidout = json['is_paidout'];
    jsonMetadata = json['json_metadata'] != null
        ? new JsonMetadata.fromJson(json['json_metadata'])
        : null;
    maxAcceptedPayout = json['max_accepted_payout'];
    netRshares = json['net_rshares'];
    payout = json['payout'];
    payoutAt = json['payout_at'];
    pendingPayoutValue = json['pending_payout_value'];
    percentHbd = json['percent_hbd'];
    permlink = json['permlink'];
    postId = json['post_id'];
    promoted = json['promoted'];
    reblogs = json['reblogs'];
    // if (json['replies'] != null) {
    //   replies = <Null>[];
    //   json['replies'].forEach((v) {
    //     replies!.add(new Null.fromJson(v));
    //   });
    // }
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    title = json['title'];
    updated = json['updated'];
    url = json['url'];
    communityTitle = json['community_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeVotes != null) {
      data['active_votes'] = this.activeVotes!.map((v) => v.toJson()).toList();
    }
    data['author'] = this.author;
    data['author_payout_value'] = this.authorPayoutValue;
    data['author_reputation'] = this.authorReputation;
    if (this.beneficiaries != null) {
      data['beneficiaries'] =
          this.beneficiaries!.map((v) => v.toJson()).toList();
    }
    // if (this.blacklists != null) {
    //   data['blacklists'] = this.blacklists!.map((v) => v.toJson()).toList();
    // }
    data['body'] = this.body;
    data['category'] = this.category;
    data['children'] = this.children;
    data['created'] = this.created;
    data['curator_payout_value'] = this.curatorPayoutValue;
    data['depth'] = this.depth;
    data['is_paidout'] = this.isPaidout;
    if (this.jsonMetadata != null) {
      data['json_metadata'] = this.jsonMetadata!.toJson();
    }
    data['max_accepted_payout'] = this.maxAcceptedPayout;
    data['net_rshares'] = this.netRshares;
    data['payout'] = this.payout;
    data['payout_at'] = this.payoutAt;
    data['pending_payout_value'] = this.pendingPayoutValue;
    data['percent_hbd'] = this.percentHbd;
    data['permlink'] = this.permlink;
    data['post_id'] = this.postId;
    data['promoted'] = this.promoted;
    data['reblogs'] = this.reblogs;
    // if (this.replies != null) {
    //   data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    // }
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    data['title'] = this.title;
    data['updated'] = this.updated;
    data['url'] = this.url;
    data['community_title'] = this.communityTitle;
    return data;
  }
}

class ActiveVotes {
  int? rshares;
  String? voter;

  ActiveVotes({this.rshares, this.voter});

  ActiveVotes.fromJson(Map<String, dynamic> json) {
    rshares = json['rshares'];
    voter = json['voter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rshares'] = this.rshares;
    data['voter'] = this.voter;
    return data;
  }
}

class Beneficiaries {
  String? account;
  int? weight;

  Beneficiaries({this.account, this.weight});

  Beneficiaries.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['weight'] = this.weight;
    return data;
  }
}

class JsonMetadata {
  String? app;
  String? description;
  String? format;
  List<String>? image;
  List<String>? tags;
  List<String>? users;

  JsonMetadata(
      {this.app,
        this.description,
        this.format,
        this.image,
        this.tags,
        this.users});

  JsonMetadata.fromJson(Map<String, dynamic> json) {
    app = json['app'];
    description = json['description'];
    format = json['format'];

    image = (json['image'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    users = (json['users'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    // image = json['image'].cast<String>();
    // tags = json['tags'].cast<String>();
    // users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app'] = this.app;
    data['description'] = this.description;
    data['format'] = this.format;
    data['image'] = this.image;
    data['tags'] = this.tags;
    data['users'] = this.users;
    return data;
  }
}

class Stats {
  int? flagWeight;
  bool? gray;
  bool? hide;
  int? totalVotes;

  Stats({this.flagWeight, this.gray, this.hide, this.totalVotes});

  Stats.fromJson(Map<String, dynamic> json) {
    // flagWeight = json['flag_weight'];
    if (json['flag_weight'] != null) {
      if (json['flag_weight'] is double) {
        flagWeight = (json['flag_weight'] as double).toInt();
      } else {
        flagWeight = json['flag_weight'] as int;
      }
    }
    gray = json['gray'];
    hide = json['hide'];
    totalVotes = json['total_votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag_weight'] = this.flagWeight;
    data['gray'] = this.gray;
    data['hide'] = this.hide;
    data['total_votes'] = this.totalVotes;
    return data;
  }
}