//
//  Agora Media SDK
//
//  Created by Rao Qi in 2019.
//  Copyright (c) 2019 Agora IO. All rights reserved.
//
#pragma once

#include <atomic>
#include <mutex>
#include <utility>
#include <vector>

namespace agora {
namespace rtc {

template <typename STATE_TYPE, typename REASON_TYPE>
using StateEvent = std::pair<uint64_t, std::pair<STATE_TYPE, REASON_TYPE>>;

template <typename STATE_TYPE, typename REASON_TYPE>
using StateEvents = std::vector<StateEvent<STATE_TYPE, REASON_TYPE>>;

template <typename STATE_TYPE, typename REASON_TYPE>
class StateNotifier {
 public:
  explicit StateNotifier(STATE_TYPE init_value) : current_state_(init_value) {}
  ~StateNotifier() {}

  void Notify(uint64_t ts, STATE_TYPE state, REASON_TYPE reason) {
    if (current_state_.exchange(state) == state) {
      return;
    }

    std::lock_guard<std::mutex> _(lock_);
    events_.push_back({ts, {state, reason}});
  }

  StateEvents<STATE_TYPE, REASON_TYPE>  GetEvents(bool readOnly = false) {
    StateEvents<STATE_TYPE, REASON_TYPE> retEvents;
    std::lock_guard<std::mutex> _(lock_);
    if (!readOnly) {
      retEvents.swap(events_);
    } else {
      retEvents.assign(events_.begin(), events_.end());
    }
    return retEvents;
  }

  bool PopEvent(STATE_TYPE state, StateEvent<STATE_TYPE, REASON_TYPE>& retEvent) {
    std::lock_guard<std::mutex> _(lock_);
    bool found = false;
    std::size_t events_size = events_.size();
    for (std::size_t i = 0; i < events_size; ++i) {
      if (events_[i].second.first == state) {
        retEvent = events_[i];
        for (int j = i; j < events_size - 1; ++j) {
          events_[j] = events_[j + 1];
        }
        events_.pop_back();
        found = true;
        break;
      }
    }
    return found;
  }

  STATE_TYPE CurrentState() { return current_state_; }

 private:
  std::atomic<STATE_TYPE> current_state_;
  std::mutex lock_;
  StateEvents<STATE_TYPE, REASON_TYPE> events_;
};

}  // namespace rtc
}  // namespace agora
