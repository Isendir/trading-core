;;;; event.lisp

(in-package #:trading-core)

(defclass fsm-agent (fsm agent)
  ((states :accessor states :initform nil)))

;;; FSM-Agent methods

(defmethod update ((a fsm-agent) (e comm))
  (set-fsm a)
  (logv:format-log "Set FSM completed for ~S~%" a)
  (logv:format-log "MAIN method completed for ~S and COMM event ~S~%" a e))

(defmethod update ((a fsm-agent) (e market-update))
  (set-fsm a)
  (logv:format-log "Set FSM completed for ~S~%" (name a))
  (operate-fsm a e)
  (logv:format-log "Operate FSM completed for ~S~%" (name a))
  (push (current-state a) (states a))
  (logv:format-log ":MAIN completed for ~S and new state ~S added ~%"
          (name a) (current-state a)))


;;EOF