local M = {
  "huggingface/llm.nvim",
  enabled = false,
  opts = {
    backend = "openai",
    model = "model1",
    url = "http://localhost:9652",

    context_window = 12000,

    request_body = {
      temperature = 0.2,
      top_p = 0.95,
      max_new_tokens = 256,
      frequency_penalty = 0.0,
      presence_penalty = 0.0,
    },

    fim = {
      enabled = false,
    },
  },
}

return M
